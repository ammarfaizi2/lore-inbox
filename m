Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTB0QXS>; Thu, 27 Feb 2003 11:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTB0QXS>; Thu, 27 Feb 2003 11:23:18 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:38155 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S265457AbTB0QXR>; Thu, 27 Feb 2003 11:23:17 -0500
Date: Thu, 27 Feb 2003 16:33:04 +0000
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Greg KH <greg@kroah.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] dm: __LOW macro fix no. 2
Message-ID: <20030227163304.GA7464@fib011235813.fsnet.co.uk>
References: <20030227095522.GA6312@fib011235813.fsnet.co.uk> <200302271617.h1RGH5CA012080@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302271617.h1RGH5CA012080@eeyore.valparaiso.cl>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 01:17:05PM -0300, Horst von Brand wrote:
> I'd add () around r and l just for paranoia's sake. Plus make sure they
> aren't ever going to be called with sideeffects... why not inline functions?

because the types vary :(

> Besides, I'd call them args a and b (no real reason for l and r, and l is
> almost 1 for some fonts...)

l and r stood for left and right from when it was a compare and assign
operator.

- Joe
