Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbTHVBGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 21:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbTHVBGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 21:06:23 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:10258 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262973AbTHVBGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 21:06:19 -0400
Date: Thu, 21 Aug 2003 18:06:15 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage: how to ruin your hardware(?)
Message-ID: <20030822010615.GI21451@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <mMAP.NQ.15@gated-at.bofh.it> <mMUh.12N.19@gated-at.bofh.it> <mUI5.7Hp.27@gated-at.bofh.it> <3F44BC9F.7030606@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F44BC9F.7030606@softhome.net>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Boo!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 02:35:43PM +0200, Ihar 'Philips' Filipau wrote:
> Maciej Soltysiak wrote:
> >
> >Maybe a message of caution should be displayed in usb-storage
> >configure help about attemtping to change partitions and/or filesystems on
> >USB storage devices.
> >
> 
>   The stuff I have met with CompactFlash cards (*without* USB) - they 
> by default were coming formated with single FAT12 partition - no 
> partition table whatsoever.
>   I had no problems with partitioning and formating (in IDE emulation 
> mode).
> 
>   But Windoz2kOfBugs was refusing to work with flashes which had 
> partition table, and was working Okay with /original/ FAT12 formated 
> flashes. Windoz wasn't even trying to read partition table, always 
> showing flash as one drive - and sure it was reporting stupid errors 
> when you were trying to do something with partitioned flash.
> 
>   It looks like /agreement/ (with The Beast) that flashe/memory card 
> has to have FAT12.

To flesh this out.

Both using PC card adapter and USB the SmartMedia cards i've
used do have partition tables with only partition 1 being
defined. The filesystem type and ID has been either a FAT12
or FAT16 depending on size.

I have not tried changing the table or filesystem type since
i use them almost exclusively for the digicams.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
