Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318870AbSG1Aoq>; Sat, 27 Jul 2002 20:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318872AbSG1Aoq>; Sat, 27 Jul 2002 20:44:46 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:242 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318870AbSG1Aoq>; Sat, 27 Jul 2002 20:44:46 -0400
Subject: Re: Linux-2.5.28
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>, Daniel Egger <degger@fhm.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20020727235726.GB26742@win.tue.nl>
References: <1027553482.11881.5.camel@sonja.de.interearth.com>
	<Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com> 
	<20020727235726.GB26742@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jul 2002 03:02:22 +0100
Message-Id: <1027821742.21511.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-28 at 00:57, Andries Brouwer wrote:
> This evening I ran vanilla 2.5.29 and was rewarded with mild filesystem damage.
> 91 files in /lost+found. Nothing. A few kernel versions ago it was three
> orders of magnitude worse.
> 
> IDE? 2.4.17 and 2.5.27+Jens are stable for me in ordinary use.
> IRQ? Quite possible.
> My third candidate is USB. Systems without USB are clearly more stable.

USB may have problems but on my test sets with 2.5.of those that booted,
the scsi ones are pretty stable, the IDE ones eat disks or hang (mostly
hang). USB loaded on some of the IDE boxes, the SCSI test boxes dont
have USB.

I've not tried the forward port of the stable IDE code with the test
loads. My SMP 2.5.27 test set on 2.5.27-ac1 (all the bits of which are
in 2.5.29) with symbios scsi on a dual PPro has been running for 6 days.


