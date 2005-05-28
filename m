Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVE1OG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVE1OG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 10:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVE1OG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 10:06:58 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:25536 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262727AbVE1OGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 10:06:53 -0400
Subject: Re: How to find if BIOS has already enabled the device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: John Livingston <jujutama@comcast.net>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200505280957.46853.kernel-stuff@comcast.net>
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com>
	 <200505272150.15109.kernel-stuff@comcast.net>
	 <4297E475.3040906@comcast.net>
	 <200505280957.46853.kernel-stuff@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117289090.2390.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 May 2005 15:04:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-05-28 at 14:57, Parag Warudkar wrote:
> This current problem of Hang-On-Boot if USB drive is attached does not happen 
> with Windows - so it is some sort of additional (unnecessary?) thing which 
> Linux does and the BIOS doesn't like.  (Like re-enabling the controller even 
> if BIOS has already enabled it or some such.)

Provide dmesg output and we might be able to guess. The first obvious
candidate would be the BIOS refusing to do a handover if it booted from
USB disk.

