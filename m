Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUH0Xpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUH0Xpz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUH0Xpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:45:51 -0400
Received: from snat.supernetwork.cz ([81.31.19.1]:32128 "EHLO
	lindik.prosek.czf") by vger.kernel.org with ESMTP id S267350AbUH0Xpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:45:35 -0400
Message-ID: <412FC7A7.4030100@scssoft.com>
Date: Sat, 28 Aug 2004 01:45:43 +0200
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
References: <412F5D50.7000807@findus.dhs.org>
In-Reply-To: <412F5D50.7000807@findus.dhs.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petter Sundlöf wrote:
> Using 2.6.8.1. DMA works fine on /dev/hda (PATA, CD burner).
> 
> When I try to enable it for my SATA drive (which is performing horribly 
> bad -- 80-90% CPU load on an AMD64 3200+ during copy of large files)

Hello,

just a 'me too' e-mail... I have Master2-FAR mobo, VIA/KT800 chipset.
IDE disk runs like a charm but SATA disks consume big amount of cpu
time (which is spent in iowait). The system behaves exactly as with
old IDE disk and DMA disabled... everything is slow when data is 
transferred to/from disk.

I have played with various settings, io schedulers, acpi... but haven't
found anything useful so far..

Regards,
Petr
