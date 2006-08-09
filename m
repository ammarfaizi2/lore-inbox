Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWHIRmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWHIRmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWHIRmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:42:54 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:62994 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751219AbWHIRmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:42:53 -0400
Date: Wed, 9 Aug 2006 13:42:52 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Christian Axelsson <smiler@lanil.mine.nu>
cc: linux-kernel@vger.kernel.org, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] USB x-pad problems
In-Reply-To: <44DA1410.4080503@lanil.mine.nu>
Message-ID: <Pine.LNX.4.44L0.0608091341370.7248-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006, Christian Axelsson wrote:

> Alan Stern wrote:
> > From your log, it looks like the computer has trouble communicating with 
> > the external hub.  What happens if you plug the X-box dancepad directly 
> > into the computer, bypassing the hub?
> 
>  From what I know this is directly into my computer (directly into the 
> motherboard atleast :P).

I guess the hub is built directly into the X-pad.

This may or may not help...  If you build a kernel with CONFIG_USB_DEBUG 
set, the dmesg log will then contain more detailed information about what 
happens when you plug in the X-pad.

Alan Stern

