Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUC3X5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbUC3X5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:57:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:20679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262064AbUC3X5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:57:36 -0500
Date: Tue, 30 Mar 2004 15:57:12 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: maneesh@in.ibm.com, stern@rowland.harvard.edu, david-b@pacbell.net,
       viro@math.psu.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-ID: <20040330235712.GA9219@kroah.com>
References: <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org> <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com> <20040329153117.558c3263.akpm@osdl.org> <20040330055135.GA8448@in.ibm.com> <20040330230142.GA13571@kroah.com> <20040330151637.6f5a688b.akpm@osdl.org> <20040330233001.GA29859@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330233001.GA29859@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 03:30:01PM -0800, Greg KH wrote:
> 
> Let me run some tests with Maneesh's patch pulled out to see if that
> solves the oopses I can generate...

With the patch removed, I can't oops the kernel.  With it in, I can
easily oops it.  So I sent the backout patch to Linus.

I'll work with Maneesh to try to solve the original problem that he saw
and tried to fix in such a way that does not cause other problems.

thanks,

greg k-h
