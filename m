Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317437AbSFCRkv>; Mon, 3 Jun 2002 13:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317438AbSFCRku>; Mon, 3 Jun 2002 13:40:50 -0400
Received: from boxer.fnal.gov ([131.225.80.86]:49794 "EHLO boxer.fnal.gov")
	by vger.kernel.org with ESMTP id <S317437AbSFCRks>;
	Mon, 3 Jun 2002 13:40:48 -0400
Date: Mon, 3 Jun 2002 12:40:49 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: <linux-kernel@vger.kernel.org>
Subject: Serverworks OSB4 in impossible state.    
Message-ID: <Pine.LNX.4.31.0206031234370.12103-100000@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Configuration:  Supermicro 370DLE motherboard, 2x1GHz pentium III,
Redhat 7.1 plus 2.4.18-4 kernel as shipped from Redhat,
Three IBM disks, hda=20Gb, hdc,hdd=40Gb, hdb=cdrom.

This system and 100-some others like it have had some kind
of DMA problems at every level of kernel and with
three different vendors of system disk...but was pretty
stable at 2.4.9 kernel and IBM system disks, also with 2.2.19
kernel and IBM system disks.

Now with 2.4.18 we get the following error, and the
system hangs:


Serverworks OSB4 in impossible state.
Disable UDMA or if you are using Seagate then try switching disk types
on this controller. Please report this event to osb4-bug@ide.cabal.tm
OSB4: continuing might cause disk corruption.

This is the only one of 60 machines thus configured that has
had the error thus far.

Two points:
1) The E-mail address in that kernel debug message doesn't exist.
E-mail bounces back from it.

2) What is causing the hang and are there any hopes to
fix it in software this time?  Last year when I came to the kernel
list with problems very similar, the consensus was that this
is actually broken hardware in the OSB4 chipset...but obviously
it is possible for at least some kernels to run quasi-normally
on this hardware... what changed between 2.4.9 and 2.4.18 so
it doesn't anymore?

Steve Timm


------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

