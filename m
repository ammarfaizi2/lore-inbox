Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbULZREb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbULZREb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 12:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbULZREb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 12:04:31 -0500
Received: from netrider.rowland.org ([192.131.102.5]:29715 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S261707AbULZREa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 12:04:30 -0500
Date: Sun, 26 Dec 2004 12:04:28 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: LKML <linux-kernel@vger.kernel.org>,
       USB users list <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] Re: Ho ho ho - Linux v2.6.10 [USB Issues]
In-Reply-To: <122620041513.15494.41CED5020009670D00003C86220075115000009A9B9CD3040A029D0A05@comcast.net>
Message-ID: <Pine.LNX.4.44L0.0412261201300.18887-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004, Parag Warudkar wrote:

> The USB mouse (Kensington Pocket Pro) on my laptop (Athlon64) stopped
> working after I switched to 2.6.10 from FC3-2.6.9 (I get an USB HC
> Takeover failed message after I connect the mouse). Also my other two
> USB storage devices (iPod and Maxtor External drive) generate an
> 'read/64' error when connected but work fine.

The read/64 message indicates a non-fatal error, as you've seen.  If you 
care to, you may be able to avoid it by loading usbcore.ko with the

	old_scheme_first=y

module parameter.

Alan Stern

