Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWGVXwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWGVXwu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 19:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWGVXwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 19:52:50 -0400
Received: from mx2.rowland.org ([192.131.102.7]:32011 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1750710AbWGVXwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 19:52:49 -0400
Date: Sat, 22 Jul 2006 19:52:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Ian Stirling <tandra@mauve.plus.com>
cc: linux-kernel@vger.kernel.org, <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] USB snd-usb-audio wedges lsusb when unplugged
 while playing sound.
In-Reply-To: <44C21635.5090808@mauve.plus.com>
Message-ID: <Pine.LNX.4.44L0.0607221951320.3059-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006, Ian Stirling wrote:

> Config/... as my earlier message on USB - though with the bandwidth 
> enforcement
> turned off so it actually plays sound, when plugged into the USB1 port.

As you have found out, bandwidth allocation in the uhci-hcd driver is
completely broken.  Don't try to use it.

Alan Stern

