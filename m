Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945980AbWANCUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945980AbWANCUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945981AbWANCUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:20:20 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:31970 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1945980AbWANCUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:20:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: 2.6.8.1-ck7, Two Badnessess, one dump.
Date: Sat, 14 Jan 2006 13:19:58 +1100
User-Agent: KMail/1.9
Cc: Joshua Schmidlkofer <kernel@pacrimopen.com>, jch@imr-net.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff Wells <clifford.wells@comcast.net>
References: <41412765.4010005@kolivas.org> <41451957.7000101@kolivas.org> <4145BAE9.1040800@pacrimopen.com>
In-Reply-To: <4145BAE9.1040800@pacrimopen.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141319.59227.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 01:21, Joshua Schmidlkofer wrote:
> Con,
>
>
>     I did not mention before, I thought it was a fluke on my system. Now
> its affecting two systems since applying ck7.
>
>
> <snip>
> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
>
> ide: failed opcode was: unknown
> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
> DataRequest }ide: failed opcode was 100
> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
>
> ide: failed opcode was: unknown
> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
> DataRequest }ide: failed opcode was 100
> hda: CHECK for good STATUS
> <snip>
>
> That is happening while applying the dma settings to the hard drive.

It's not a very informative message but probably just means the kernel is 
complaining about what that (evil) program hdparm is trying to do. Anyway 
this kernel is _ancient_. Please move to a newer one if you can (yes I 
understand the reasons stick to older kernels so don't bother explaining them 
- that's why I said "if you can").

Cheers,
Con
