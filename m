Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRJLPrU>; Fri, 12 Oct 2001 11:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277739AbRJLPrL>; Fri, 12 Oct 2001 11:47:11 -0400
Received: from wing0.lancs.ac.uk ([148.88.1.12]:64699 "EHLO wing0.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S277738AbRJLPrC>;
	Fri, 12 Oct 2001 11:47:02 -0400
Message-Id: <200110121547.f9CFlXx11575@wing0.lancs.ac.uk>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: steveb@unix.lancs.ac.uk
Date: Fri, 12 Oct 2001 16:47:33 +0100
Subject: kernel not booting when configured for Athlon
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just replace my Pentium-III system with an Athlon-based one, I rebuilt
the kernel with 'processor Family' changed from 'Pentium III' to Athlon/Duron/K7, and it failed to boot - it goes as far as "OK, booting the kernel" and hangs.

I can boot a kernel supposedly built for Pentium-III without any apparent problems.

My system is a 1.4GHz Athlon, 512MB 2100DDR memory, ASUS A7A266 system board (ALI M1647 chipset).

I've tried kernel versions 2.4.9, 2.4.11 (briefly), and 2.4.12, all with the same effect.

I've tried gcc-3.0.1 and gcc-2.96-81 (from RedHat 7.1), both have the same effect.

I've upgraded the BIOS from Rev 1006 to 1007 (the most recent), this makes no difference.

I've seen some discussion on here about a patch for Athlon motherboards, this doesn't appear to be relevant since it seems to be for a different chipset to mine.

/proc/cpuinfo reports:

  processor       : 0
  vendor_id       : AuthenticAMD
  cpu family      : 6
  model           : 4
  model name      : AMD Athlon(tm) Processor
  stepping        : 4
  cpu MHz         : 1410.328
  cache size      : 256 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr
  pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
  bogomips        : 2811.49


1) Am I doing anything stupid here?
2) Are there any issues with running a kernel configured for a Pentium III on an Athlon? It seems stable so far.

-- 
Steve Bennett
