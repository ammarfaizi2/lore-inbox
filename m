Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSFIXvy>; Sun, 9 Jun 2002 19:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSFIXvx>; Sun, 9 Jun 2002 19:51:53 -0400
Received: from jalon.able.es ([212.97.163.2]:7638 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315372AbSFIXvw>;
	Sun, 9 Jun 2002 19:51:52 -0400
Date: Mon, 10 Jun 2002 01:51:46 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.19-pre10-jam2
Message-ID: <20020609235146.GC2428@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.

New release, with some updates:

- 00-aa-pre10aa2: syn with -aa tree. It includes now the full vm update
  (obviously), the O1 scheduler, all the mini-lowlatency patch and all
  the pending buglets in 2.4.19-pre.
- 02-config-nr-cpus: config hardcoded max nuber of cpus, saves some memory
  in kernel internal structures.
- 40-ide-10: intorduce again the ide-convert-10 patch from Andre.
  WARNING: I think the merge is ok wrt the hihgio changes, but anything
  can happen, beware it can eat your disk. But, plz, test it (he, he...)
  (a chance to test Andre code+highmem-io, that Randy says is much faster...)
- 41-ide-cd-dma: audio dma again also
- Some bits to play with makefiles
  * 91-x86-model: split pII from PPro
  * 92-gcc3-march: use more specific compile flags if using gcc3
  * 93-gcc-Os: build with -Os instead of -O2. It reduces kernel size
    (940 -> 850 Kb in my box), without a noticeable perforamce loss.
    Sure this is true ?? Try it.

Get it at:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre10-jam2/
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre10-jam2.tar.bz2

Enjoy


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre10-jam2 #3 SMP sáb jun 8 03:42:18 CEST 2002 i686
