Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVLGT7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVLGT7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVLGT7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:59:45 -0500
Received: from bay103-f32.bay103.hotmail.com ([65.54.174.42]:54484 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1030337AbVLGT7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:59:44 -0500
Message-ID: <BAY103-F32F90C9849D407E9336826DF430@phx.gbl>
X-Originating-IP: [68.75.180.115]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <20051207155034.GB6793@flint.arm.linux.org.uk>
From: "Jason Dravet" <dravet@hotmail.com>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Date: Wed, 07 Dec 2005 13:59:43 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Dec 2005 19:59:44.0188 (UTC) FILETIME=[C480E7C0:01C5FB68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Russell King <rmk+lkml@arm.linux.org.uk>
>To: Jason Dravet <dravet@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: wrong number of serial port detected
>Date: Wed, 7 Dec 2005 15:50:34 +0000
>
>On Wed, Dec 07, 2005 at 09:44:29AM -0600, Jason Dravet wrote:
> > So I ask this mailing list Can the kernel detect the proper number of
> > serial ports or not?
>
>It does detect serial ports found in the machine.
>
>However, it _always_ offers the configured number of serial devices.
>This is to allow folk whose ports are not autodetected to configure
>them appropriately via the setserial command.  If they were not
>available, they could not configure them.
>
Then may I ask how XP does it?  I have to dual boot between XP and Fedora.  
When I go into XP's device manager I see all of the appropriate hardware 
listed, no extra serial ports.  When I boot into Fedora and go into /dev, I 
see the same hardware except I have 32 serial ports and 64 tty nodes (tty is 
for virtual terminals right?).  How can 1 OS show the correct number and 
another show the wrong number?  I ask so I can better understand what is 
going on.

Thanks,
Jason


