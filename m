Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131930AbRBOBBT>; Wed, 14 Feb 2001 20:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131956AbRBOBBJ>; Wed, 14 Feb 2001 20:01:09 -0500
Received: from [213.97.184.209] ([213.97.184.209]:1152 "HELO
	ksoft.dnsalias.net") by vger.kernel.org with SMTP
	id <S131930AbRBOBAw>; Wed, 14 Feb 2001 20:00:52 -0500
Date: Thu, 15 Feb 2001 02:00:39 +0100 (CET)
From: German Gomez Garcia <kahuna@ksoft.dnsalias.net>
Reply-To: german@pinon.ccu.uniovi.es
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Manual SCSI bus reset?
Message-ID: <Pine.LNX.4.21.0102150148190.210-100000@ksoft.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I've got Plexwriter 12x10x32S attached to an onbard AIC7890
(besides other things as three IBM UWSCSI harddisks, an SCSI ZIP and a
Pioneer DVD) and sometimes when recording a CD the Plexwriter fails at the
very end of the process (although the CD is recorded correctly) and it is
locked with no posibility to eject it (it seems that a failure while
reading from the DVD during on-the-fly recording is the cause). 

	But if I reset the SCSI bus manually, that is trying to read from
a "reset-it CD", that is completely broken and makes the SCSI bus resets
itself, I can eject the CD from the Plexwriter. So I would like to know if
there is a way to do it without that trick. I've downloaded some utilities
for the SCSI generic driver, one of them should let you reset the bus (or
even just a single device) but it fails with "SCSI_RESET" not supported
and after reading through the docs it seems that the kernel (or should I
say the SCSI drivers) doesn't support this kind of reset.
	
	I would like to know if this is "kernel politics", "faulty
hardware", or just lazy programmers ;-), thanks and please CC the answer
to me as I'm not subscribed to this mailing list.

	- german

---------------------------------------------------------------------------
German Gomez Garcia           | "This isn't right.  This isn't even wrong."
<german@pinon.ccu.uniovi.es>  |                         -- Wolfgang Pauli

