Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318030AbSGRM0X>; Thu, 18 Jul 2002 08:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSGRM0X>; Thu, 18 Jul 2002 08:26:23 -0400
Received: from a215-141.dialup.iol.cz ([194.228.141.215]:20228 "EHLO devix")
	by vger.kernel.org with ESMTP id <S318030AbSGRM0V>;
	Thu, 18 Jul 2002 08:26:21 -0400
Date: Thu, 18 Jul 2002 12:51:46 +0200 (CEST)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18 is not SMP friendly
Message-ID: <Pine.LNX.4.33.0207181244550.535-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I someone here running 2.4.18 on PII SMP successfully ?
My SMP box was happily running 2.4.3 but after upgrade
to 2.4.18 I got 3 oopses in 4 days.
All was FS related, one during heavy access to SCSI and
IDE in paralel (I post ksymoops output recently but nobody
seemed interested) ane during cdrecord running in paralel
with SCSI HDD (IDE cdwritter) and latest when trying to
mount IDE ZIP drive with corrupted ZIP floppy. Latest
resulted in system panic and freeze so no output here :(

This is like scream into dark because I rebooted with
maxcpus=1 and it seems to be ok now and I don't want to
experiment with production server anymore.
But is someone knows the problem I'm willing to test some
patches, hacks .. etc
Seems to me like missing spinlock somewhere ..

thanks,
devik

