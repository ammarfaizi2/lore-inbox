Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270772AbRIBM3G>; Sun, 2 Sep 2001 08:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271329AbRIBM24>; Sun, 2 Sep 2001 08:28:56 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:19986 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270772AbRIBM2m>; Sun, 2 Sep 2001 08:28:42 -0400
Message-ID: <3B922604.A8E3EB5F@folkwang-hochschule.de>
Date: Sun, 02 Sep 2001 14:28:52 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: nettings@folkwang-hochschule.de
Subject: 2.4.8-ac11 lockup when burning cds
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello *

i see hard lockups in 2.4.8-ac11 when i try to burn a cd.
after a few seconds into the burning (with cdrecord), the console
locks.
i cannot switch to other vc's or back to X.
no log entries survive. 
the box does not react to sysrq's.
i cannot ssh into it, but the hub showed continuing net traffic,
possibly from a download in the background, so there seemed to be
something still alive.
after a few minutes wait, i reset the machine.

system is:
* dual p3/600, 512m, mobo is asus p2b-ds
* a scsi disk and cdrom on scsi bus 0 with an adaptec aic7xxx
(onboard)
* an ide disk on ide channel 1 (master)
* an ide cdrecorder on ide channel 0 (master), running as a virtual
scsi device on scsi bus 2

sorry if this has been posted before, i'm not subscribed to lkml.
however, an archive search yielded nothing similar.

please keep me cc:ed on replies. thanks.

will try the latest ac patch now.

all the best,

jörn


-- 
+Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/
