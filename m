Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSKRAiy>; Sun, 17 Nov 2002 19:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSKRAiy>; Sun, 17 Nov 2002 19:38:54 -0500
Received: from venema.csee.wvu.edu ([157.182.194.151]:44771 "EHLO
	mail.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S261302AbSKRAiw>; Sun, 17 Nov 2002 19:38:52 -0500
Subject: Compiling packages from source on Ultrasparc
From: Shanti Katta <katta@csee.wvu.edu>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 17 Nov 2002 20:00:11 -0500
Message-Id: <1037581211.30240.17.camel@indus.csee.wvu.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I understand that userland is 32-bit on Ultrasparc. I am trying to
compile user-mode-linux on Ultrasparc, and I guess I need to compile it
in 32-bit mode for it to run as a normal user-level process. UML make
use of certain files in asm-{base-arch} during compilation. Now, to
compile uml in 32-bit mode, I did not include any flags in
makefiles(like -m64, -mcpu=ultrasparc) that would include 64-bit
specific asm code.
My question is that, what difference does it make when I compile UML, in
a sparc32 shell, as compared to the above process without executing the
sparc32 shell. I understand that if compiled in sparc32 shell, it
recognizes the host-arch as "sparc" instead of "sparc64". But other than
that, does it make any other difference? I am also not sure, which is
the right method for compiling UML.
Any pointers will be appreciated.

-Shanti 



