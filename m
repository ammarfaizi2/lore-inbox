Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315262AbSEFXk1>; Mon, 6 May 2002 19:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315263AbSEFXk0>; Mon, 6 May 2002 19:40:26 -0400
Received: from jalon.able.es ([212.97.163.2]:11472 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315262AbSEFXkZ>;
	Mon, 6 May 2002 19:40:25 -0400
Date: Tue, 7 May 2002 01:27:21 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: P4 Xeon summary inquiry
Message-ID: <20020506232721.GC3019@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

I am trying to make a dual P4-Xeon box (P4DCE, Intel 869) work optimally.
After some search in list archives, I have found this points:

- You need ACPI, and boot with acpismp=force, to have hyperthreading
  (see 4 cpus)
- To balance interrupts, a patch from Ingo is needed
- To balance timers, one other patch was needed, but this in included
  in 2.4.19-pre8 (do not know since which pre is there)

I tried to boot with acpismp=force, but then performance was dog slow,
I could count lines scrolling on a rxvt.
I checked mtrr and look like working. Box has 1Gb of ram, so kernel
is using CONFIG_HIGHMEM4G=y.
Kernel is the standard highmem Mandrake kernel in 8.2
(2.4.18-6mdkenterprise) that is mainly a plain 2.4.18 with some
.19-pre1 fixes.

Any correction ? Any known problem in 2.4.18 about this issue that
has bee corrected in pres for 19 ?

Any idea about the performance loss ?

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam1 #1 SMP dom may 5 23:46:04 CEST 2002 i686
