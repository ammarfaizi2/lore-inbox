Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264669AbSJ3N4o>; Wed, 30 Oct 2002 08:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSJ3N4o>; Wed, 30 Oct 2002 08:56:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:65408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264669AbSJ3N4n>; Wed, 30 Oct 2002 08:56:43 -0500
Date: Wed, 30 Oct 2002 09:04:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roberto Fichera <kernel@tekno-soft.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <5.1.1.6.0.20021030132848.03a12ec0@mail.isolaweb.it>
Message-ID: <Pine.LNX.3.95.1021030090019.5487A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Roberto Fichera wrote:

> I've a problem with a DAT on a Compaq Proliant ML350 with PIII 1GHz,
> 1Gb RAM, RAID controller Smart Array 451 with 3 x HDD 9Gb RAID 5
> and an internal SCSI controller Adaptec 7899 Ultra160 where is connected
> only a DAT 12/24 Gb. Current installed distribution is RH7.3 with its kernel
> 2.4.18-10 but I've tryed the standard 2.4.19 with the same problem.
> The problem is that the DAT don't work any more with Linux. This DAT work
> well on Win2K :-(! Below  there is some logs and a 'ps fax' showing a tar in
> D state.
> 
> Does anyone know a solution ?

> 
> Adaptec AIC7xxx driver version: 6.2.6
> aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> Corrupted Serial EEPROM
^^^^^^^^^^^^^^^^^^^^^^^^^

I think your controller has fallen-back into survival mode
because it lost it's mind. You may want to upgrade the
controller BIOS to fix this problem. Then, see if it handles
tapes okay.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


