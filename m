Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbTLKRyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbTLKRye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:54:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:33197 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265208AbTLKRxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:53:04 -0500
Date: Thu, 11 Dec 2003 09:50:54 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>, maneesh@in.ibm.com, mgorse@mgorse.dhs.org,
       linux-kernel@vger.kernel.org, Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: oopses in kobjects in 2.6.0-test11 (was Re: kobject patch)
Message-ID: <20031211175053.GA7790@kroah.com>
References: <20031009014837.4ff71634.akpm@osdl.org> <20031208222526.GA31134@kroah.com> <20031208224810.GB31134@kroah.com> <20031208225840.GA31245@kroah.com> <Pine.LNX.4.50.0312110849040.14967-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0312110849040.14967-100000@monsoon.he.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 08:51:58AM -0800, Patrick Mochel wrote:
> 
> Sorry about the delay in getting back to you.
> 
> > Here's a patch for kobject.c that should fix this problem and keep
> > kobject parent's around until after the child is gone.  Please can
> > someone verify that I didn't get this wrong...
> 
> The patch looks good, please forward it on to Linus/Andrew.

Will do, thanks for looking it over.

greg k-h
