Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUGJNLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUGJNLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 09:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUGJNLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 09:11:09 -0400
Received: from av9-2-sn1.fre.skanova.net ([81.228.11.116]:59331 "EHLO
	av9-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S266243AbUGJNLG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 09:11:06 -0400
From: Roger Larsson <roger.larsson@norran.net>
To: linux-kernel@vger.kernel.org
Subject: Re: (att. ismail) [announce] [patch] Voluntary Kernel Preemption Patch
Date: Sat, 10 Jul 2004 15:03:58 +0200
User-Agent: KMail/1.6.82
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200407101503.58124.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tested on 2.6.7-bk20, Pentium3 700 mhz, 576 mb RAM
> 
> I did cp -rf big_folder new_folder . Then opened up a gui ftp client
> and music in amarok started to skip like for 2-3 seconds.
> 
> Btw Amarok uses Artsd ( KDE Sound Daemon ) which in turn set to use
> Jack Alsa Backend.

Are you sure that both artsd and jackd is run as RT processes?
artsd needs 'artswrapper' as suid root and option in kconfig enabled.
(never versions of amarok warns the user if this is not the case...)

[You can try to run the same as root to be sure]

But it does sound as a io scheduler problem - but 2-3 seconds!?

/RogerL 

-- 
Roger Larsson
Skellefteå
Sweden
