Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316189AbSEOIUx>; Wed, 15 May 2002 04:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316276AbSEOIUw>; Wed, 15 May 2002 04:20:52 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19205 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S316189AbSEOIUw>; Wed, 15 May 2002 04:20:52 -0400
Date: Wed, 15 May 2002 10:20:45 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE *data corruption* VIA VT8367
Message-ID: <20020515082045.GB4190@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <379487051.20020514195533@anna-strasse.de> <E177lx4-0000e6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Alan Cox wrote:

> I have multiple similar reports, and in all cases where people tried, switching
> to a non via chipset cured it - it might be co-incidence but I have enough
> reports I suspect its some kind of hardware incompatibility/limit with
> the VIA and multiple promise ide controllers

I did not see corruption on VIA KT133 (VT8363) + Promise PDC20265R in
non-RAID ("UDMA/100") mode with hda + hde. (No longer using the promise
because FreeBSD uses to talk Tagged Queueing on those old Promise
chips).

So maybe it's the newer chipset or it's rare enough it doesn't bite
everybody -- or it's infact a Promise incompatibility. (FreeBSD man
pages report Promise chips before TX2 lock up hard with ATA DMA queued
commands).

-- 
Matthias Andree
