Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRBXIoH>; Sat, 24 Feb 2001 03:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129527AbRBXIn4>; Sat, 24 Feb 2001 03:43:56 -0500
Received: from [62.122.73.172] ([62.122.73.172]:45578 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S129524AbRBXInp>; Sat, 24 Feb 2001 03:43:45 -0500
To: linux-kernel@vger.kernel.org
Subject: unable to link 2.4.2
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 24 Feb 2001 09:45:52 +0100
Message-ID: <87pug8eaf3.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there, can someone please tell me what's going wrong with my
compilation of 2.4.2 ?

make[2]: Entering directory `/usr/src/linux/arch/i386/boot'
ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
ld: cannot open binary: No such file or directory
make[2]: *** [bbootsect] Error 1
make[2]: Leaving directory `/usr/src/linux/arch/i386/boot'
make[1]: *** [bzImage] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2


root@penny:/usr/src #  . linux/scripts/ver_linux 
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux penny 2.4.1 #1 Sat Feb 3 20:43:54 CET 2001 i686 unknown
Kernel modules         2.4.2
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.91.0.2
Linux C Library        2.2.2
Dynamic linker         ldd (GNU libc) 2.2.2
Procps                 2.0.7
Mount                  2.10s
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         isofs loop binfmt_misc mousedev hid input nfsd microcode sg ipt_limit iptable_mangle ipt_MASQUERADE iptable_nat ip_conntrack ipt_LOG iptable_filter ip_tables sb sb_lib uart401 nfs ipv6 lockd sunrpc af_packet eepro100 3c509 sound soundcore isa-pnp usbcore

Thanks in advance ....

Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.1 #1 Sat Feb 3 20:43:54 CET 2001 i686 unknown
