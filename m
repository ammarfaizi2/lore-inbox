Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSGPTVK>; Tue, 16 Jul 2002 15:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSGPTVJ>; Tue, 16 Jul 2002 15:21:09 -0400
Received: from ausadmmsps306.aus.amer.dell.com ([143.166.224.101]:27403 "HELO
	AUSADMMSPS306.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S317945AbSGPTVI>; Tue, 16 Jul 2002 15:21:08 -0400
X-Server-Uuid: c21c953d-96eb-4242-880f-19bdb46bc876
Message-ID: <F44891A593A6DE4B99FDCB7CC537BBBB0724FC@AUSXMPS308.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: alan@lxorguk.ukuu.org.uk, jgarzik@mandrakesoft.com
cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: RE: Removal of pci_find_* in 2.5
Date: Tue, 16 Jul 2002 14:23:52 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 112AAD452680098-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a BIOS extension for this (EDID 3.0 I believe).

Unfortunately EDD30 isn't implemented by very many BIOSs or option roms.
The Adaptec aic7xxx series BIOSs and recent LSI-based PERC3 BIOSs are the
only ones I've found that do, but their implementations are slightly buggy.
Granted, I've limited my testing to those cards and/or onboard devices that
Dell sells.

I made a simple DOS program if people want to test boards for themselves.
(EDD30 specifies a real mode int13 extension, so it was easy to to it in
DOS, only slightly harder to do it in the boot loader or kernel before
switching to protected mode.)  Posted to http://domsch.com/linux/edd30/.
There's a results page there that I'm starting to fill in.  Please send
results to edd30@domsch.com per the README included.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

