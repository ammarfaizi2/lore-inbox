Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279661AbRKFP3J>; Tue, 6 Nov 2001 10:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279629AbRKFP3A>; Tue, 6 Nov 2001 10:29:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61449 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279658AbRKFP2h>; Tue, 6 Nov 2001 10:28:37 -0500
Subject: Re: Mylex/Compaq RAID controller placement in config
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Tue, 6 Nov 2001 15:35:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111061612570.23908-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Nov 06, 2001 04:15:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1618GQ-0000oj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > They dont provide scsi as the native interface (nor do some of the others
> > but thats a seperate saga)
> 
> I know it might seem silly, but as to make things clearer for most
> users/admins, wouldn't it be better to just call them SCSI controllers, as
> they all indeed connect SCSI drives to the host?

Well we could simplify it further by putting all configuration options under
a single menu called "things". The controllers under block dont have drives
appearing as /dev/sd*
