Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUJNVHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUJNVHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUJNVFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:05:19 -0400
Received: from ida.rowland.org ([192.131.102.52]:24580 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S267554AbUJNVD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:03:57 -0400
Date: Thu, 14 Oct 2004 17:03:56 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Laurent Riffard <laurent.riffard@free.fr>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
 : oops...]
In-Reply-To: <416EE051.40705@free.fr>
Message-ID: <Pine.LNX.4.44L0.0410141703260.1026-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Laurent Riffard wrote:

> Alan Stern wrote:
> [snip]
> > My impression is that this problem arises somewhere within or
> > below the free_irq routine.  I don't have the -mm2 sources, so I
> > can't be any more precise than that.
> 
> Here is an updated dmesg for kernel 2.6.9-rc4-mm1. But I'm afraid it 
> won't give more information, as the call stack is identical to the 
> 2.6.9-rc3-mm2 one.
> 
> I will try a vanilla kernel if it's needed.

Yes, try that.  At least if the problem still occurs, it will be easier to 
track down.

Alan Stern

