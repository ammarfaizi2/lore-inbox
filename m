Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316144AbSENXYD>; Tue, 14 May 2002 19:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316145AbSENXYC>; Tue, 14 May 2002 19:24:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24332 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316144AbSENXYC>; Tue, 14 May 2002 19:24:02 -0400
Subject: Re: IDE *data corruption* VIA VT8367
To: hgs@anna-strasse.de
Date: Wed, 15 May 2002 00:43:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <379487051.20020514195533@anna-strasse.de> from "Henning Schroeder" at May 14, 2002 07:55:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177lx4-0000e6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These combinations give errors: (hda hdc hde hdg), (hdc hde hdg)
> 
> These combinations run flawless: (hda hdc hde), (hde hdg), (hda hdc
> hdg). I did not test more combinations because every test takes some
> hours.
> 
> Attaching hdg as a slave drive to the first promise port (which gives
> me hdf instead and the second promise port emtpy) makes the array run
> fine, but performance drops to a figure comparable to a single drive.
> 
> There are no error logs whatsoever (except for the dt output). Without
> RAID-array and without heavy IDE access, the machine runs stable.
> 
> Kernels tested: 2.4.18, 2.4.19pre8
> 
> Has anybody seen this before? Any info would be appreciated. I would
> be happy to provide more information.

I have multiple similar reports, and in all cases where people tried, switching
to a non via chipset cured it - it might be co-incidence but I have enough
reports I suspect its some kind of hardware incompatibility/limit with
the VIA and multiple promise ide controllers

