Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319237AbSHNHR7>; Wed, 14 Aug 2002 03:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319238AbSHNHR7>; Wed, 14 Aug 2002 03:17:59 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12558
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319237AbSHNHR7>; Wed, 14 Aug 2002 03:17:59 -0400
Date: Wed, 14 Aug 2002 00:12:53 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ivan Gyurdiev <ivangurdiev@attbi.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.31 SCSI emulation and cd burner....severe filesystem corruption
In-Reply-To: <200208111110.22772.ivangurdiev@attbi.com>
Message-ID: <Pine.LNX.4.10.10208140008140.12468-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002, Ivan Gyurdiev wrote:

> By the way, I dared to try it again under 2.4 and it burned my disk 
> flawlessly..... so this is NOT a hardware failure.

Did you expect anything less :-)

As soon as I trace and squash an introduced bug in the delayed SATA 1.0
release for 2.4, I will do an update of the original port forward.

Also you will enjoy the added features of 2.4 soon.

echo ide-scsi:{0|1} > /proc/ide/hdX/settings

This will auto sense and discretely toggle the atapi/ide-scsi driver sets
between devices with all modules built-in.  This is a minor detail but it
is the next to last stage of dynamic devices sense on open("/dev/hdX").

Cheers,

Andre Hedrick
LAD Storage Consulting Group

