Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUCYUWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 15:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbUCYUWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 15:22:41 -0500
Received: from ida.rowland.org ([192.131.102.52]:18180 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263598AbUCYUWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 15:22:39 -0500
Date: Thu, 25 Mar 2004 15:22:39 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Colin Leroy <colin@colino.net>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Re: [linux-usb-devel] Re: [OOPS] reproducible oops with
 2.6.5-rc2-bk3
In-Reply-To: <20040325201157.6551b5e9@jack.colino.net>
Message-ID: <Pine.LNX.4.44L0.0403251521580.1083-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004, Colin Leroy wrote:

> On 25 Mar 2004 at 13h03, Alan Stern wrote:
> 
> Hi, 
> 
> > In this case, your patch could be improved by calling device_initialize()  
> > during the first loop and device_add() during the second.  However, that
> > region of code is kind of in flux right at the moment.  When things settle
> > down, I promise to remember your change and make sure it gets in.
> 
> ok :) 
> Will this get stabilized before 2.6.5 or after ? (just so I remember to patch it myself if needed...)

I don't know.  "After" is my best guess.

Alan Stern

