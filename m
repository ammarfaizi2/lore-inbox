Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272838AbRJTMF3>; Sat, 20 Oct 2001 08:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273065AbRJTMFT>; Sat, 20 Oct 2001 08:05:19 -0400
Received: from tentacle.nmd.msu.ru ([193.232.112.47]:12697 "HELO
	tentacle.nmd.msu.ru") by vger.kernel.org with SMTP
	id <S272838AbRJTMFH>; Sat, 20 Oct 2001 08:05:07 -0400
To: linux-kernel@vger.kernel.org
Subject: old but actual HPT370 & VIA IDE issue
X-Face: 24m58Avzqf)$jn8">:-jxz1Mua[e)JfGH6oN?%(%bxdo;\=oi}4_|@q_7phP@E7MuHv)9:"
 fvd1aK0MhB4Ea.@.g[`#1z4"/[5C^*NxW*):us+^b_F4^3+F5w`gSsRNa/]BDJs/b;<}Sfo^gjtkDu
 s(Kj2u1]y-01oQ1$@'3p:`NZx4Nz(0-@CxuET+-.Pdm[ie?_@PK\U;QHV
From: alex_@unis-ru.com (Alexandre N. Safiullin)
Date: 20 Oct 2001 16:05:33 +0400
Message-ID: <87lmi6ldo2.fsf@storm.dorms.msu.ru>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


 Hello!

 I have an ABIT KT7-RAID motherboard. It has two IDE controllers
 VIA (UDMA66) and HPT370 (UDMA100 w/ RAID capabilities). 
 The harddrive IBM DTLA 307030 is attached to HPT370 as a primary
 master and usually detected as hde

 But after 2.4.6 or 2.4.7 the kernel begun to hang before the message 

 hde: IBM-DTLA-307030, ATA DISK drive

 I.e. instead detecting the harddrive the kernel issues the message

 spurious 8259A interrupt: IRQ7.

 and hangs.
 There is a workaround for that. If to disable VIA IDE primary and
 secondary controllers in the BIOS everything is OK.

 Last kernel I can reproduce the issue is 2.4.13-pre5.

- -- 
 Regards, Alex_

 http://arabella.unis-ru.com/~alex_/
                                                

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE70WiN92sQeoCpYGwRAhePAJ9Ho5fk5IPCukTGH8UNVsrdxMoBjwCfS2I0
q0xMeKcZgznuxFuzgXvog4s=
=dmL+
-----END PGP SIGNATURE-----
