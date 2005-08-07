Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752172AbVHGPOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbVHGPOr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 11:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbVHGPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 11:14:46 -0400
Received: from mx1.rowland.org ([192.131.102.7]:26885 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1752172AbVHGPOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 11:14:46 -0400
Date: Sun, 7 Aug 2005 11:14:45 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Martin Maurer <martinmaurer@gmx.at>
cc: Pete Zaitcev <zaitcev@redhat.com>, <akpm@osdl.org>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: Elitegroup K7S5A + usb_storage problem
In-Reply-To: <200508070222.57340.martinmaurer@gmx.at>
Message-ID: <Pine.LNX.4.44L0.0508071112470.28316-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Aug 2005, Martin Maurer wrote:

> Hi Pete,
> 
> when using ub with your patch i get a lot further:
> the device is detected and uba+uba1 entries appear.
> I can mount the device correctly.
> Copying the files down and comparing them with the originals gives correct 
> results.
> 
> but:
> when i delete the files which are on the stick and do an umount/mount cycle, 
> the files are there again. 
> Copying files to the stick gives wrong results too.
> Once the created file vanished after the remount,
> and once it was there with a different name/size/date and garbage as content.

It sounds as though the device isn't actually carrying out the write 
operations.  Is it write-protected?

Alan Stern

