Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUEFPX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUEFPX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUEFPX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:23:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:54941 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262503AbUEFPX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:23:56 -0400
Date: Thu, 6 May 2004 17:23:50 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] report size of printk buffer
Message-ID: <20040506152350.GD14714@apps.cwi.nl>
References: <20040506133639.GB14714@apps.cwi.nl> <Pine.LNX.4.44.0405061708170.765-100000@serv.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405061708170.765-100000@serv.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 05:11:26PM +0200, Roman Zippel wrote:

> > If one asks for count bytes, one gets the last count bytes of output,
> > not the first.
> 
> That doesn't answer the question, why don't you just clear the data that
> was read?

Think about it.
The buffer is 131072 bytes. We read the final 16384 bytes.
Now what?


[There are other problems as well, but I do not want to start a complicated
conversation for a triviality.]
