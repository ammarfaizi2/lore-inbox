Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289768AbSAJXIk>; Thu, 10 Jan 2002 18:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289772AbSAJXIa>; Thu, 10 Jan 2002 18:08:30 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:51614 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S289768AbSAJXIT>; Thu, 10 Jan 2002 18:08:19 -0500
To: linux-kernel@vger.kernel.org
Subject: [Q] Looking for an emulation for CMOV* instructions.
From: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>
Date: 11 Jan 2002 00:08:17 +0100
Message-ID: <m26669olcu.fsf@goliath.csn.tu-chemnitz.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo kernel hackers,

is it possible to include an emulation for the CMOV* (and possible other
i686 instructions) for processors that dont have these (k6, pentium
etc.)? I think this should work like the fpu emulation. Even if its slow
it will allow you to work even if you tried to install a libc for i686
on an older architecture or if you have apps that are statically linked
against such a libc (rpm, e2fschk, etc.).

I found some info on this here:

        http://gwenole.beauchesne.online.fr/basilisk2/

        "... * uae_jit: added CMOV "emulation" for processors that don't
         support them ..."

Maybe this can be of any use to hack it in the kernel?

thanx,
ron

-- 
/\/\  Dipl.-Inf. Ronald Wahl                /\/\        C S N         /\/\
\/\/  ronald.wahl@informatik.tu-chemnitz.de \/\/  ------------------  \/\/
/\/\  http://www.tu-chemnitz.de/~row/       /\/\  network and system  /\/\
\/\/  GnuPG/PGP key available               \/\/    administration    \/\/
