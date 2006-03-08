Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752007AbWCHBva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbWCHBva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbWCHBva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:51:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24735 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752007AbWCHBv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:51:29 -0500
Date: Tue, 7 Mar 2006 17:49:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: oops in choose_configuration()
Message-Id: <20060307174927.39fbc475.akpm@osdl.org>
In-Reply-To: <20060308013101.GB24739@kroah.com>
References: <20060304121723.19fe9b4b.akpm@osdl.org>
	<Pine.LNX.4.64.0603041235110.22647@g5.osdl.org>
	<20060304213447.GA4445@kroah.com>
	<20060304135138.613021bd.akpm@osdl.org>
	<20060304221810.GA20011@kroah.com>
	<20060305154858.0fb0006a.akpm@osdl.org>
	<Pine.LNX.4.64.0603051840280.13139@g5.osdl.org>
	<20060306004836.3db943e0.akpm@osdl.org>
	<20060308013101.GB24739@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > a) How come we're only considering the zeroth slot in that array in here?
> 
>  We start out with the first interface setting, as we always know we have
>  one of them as per the USB spec (I think, anyone from linux-usb-devel
>  want to verify this?)

I think that code has to be OK - it's longstanding stuff and slab
debugging would have caught these sorts of things in a jiffy.

