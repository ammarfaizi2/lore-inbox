Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265958AbUGAP4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUGAP4z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUGAP4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:56:55 -0400
Received: from ida.rowland.org ([192.131.102.52]:9476 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265958AbUGAP4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:56:54 -0400
Date: Thu, 1 Jul 2004 11:56:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: linux-usb-users@lists.sourceforge.net, janne <sniff@xxx.ath.cx>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-usb-users] linux 2.6.6, bttv and usb2 data corruption &
 lockups & poor performance
In-Reply-To: <200407011726.24592.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0407011153330.1083-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004, Duncan Sands wrote:

> > Is it possible that you are exceeding the capacity of your PCI bus?
> 
> I guess so, but that's no reason to hang...  Or is overloading the PCI
> bus somehow problematic?

Well it's certainly not good!  :-)

One of the failure modes that will cause an immediate shutdown of a USB 
host controller is a PCI error.  If the controller isn't working lots of 
bad things are likely to follow.  I can imagine that even if that doesn't 
happen, PCI errors could mess up other drivers or hardware too.

Alan Stern

