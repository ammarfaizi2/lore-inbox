Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWGAStE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWGAStE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 14:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWGAStE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 14:49:04 -0400
Received: from [213.129.229.13] ([213.129.229.13]:10406 "EHLO mail.mlab.at")
	by vger.kernel.org with ESMTP id S1751277AbWGAStC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 14:49:02 -0400
Message-ID: <35895.212.17.85.16.1151779301.squirrel@mail.mlab.at>
Date: Sat, 1 Jul 2006 20:41:41 +0200 (CEST)
Subject: ingos realtime patch-2.6.17-rt5 on 2.6.17-1 PowerbookG4
From: "peter boehm" <boehm@mlab.at>
To: linux-kernel@vger.kernel.org
Reply-To: boehm@mlab.at
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

compiling kernel 2.6.17-1 with realtime patch applied (patching went
without troubles) on powerbook G4 gives following error:

----------------------------------
  CC      arch/powerpc/platforms/powermac/feature.o
arch/powerpc/platforms/powermac/feature.c:63: error: conflicting types for
'feature_lock'
include/asm/pmac_feature.h:381: error: previous declaration of
'feature_lock' was here
make[3]: *** [arch/powerpc/platforms/powermac/feature.o] Fehler 1
make[2]: *** [arch/powerpc/platforms/powermac] Fehler 2
make[1]: *** [arch/powerpc/platforms] Fehler 2
make[1]: Leaving directory `/usr/src/linux-source-2.6.17'
make: *** [debian/stamp-build-kernel] Fehler 2

-----------------------------------

without the patch the kernel compiles fine. any help?
thanks
peter
-- i am not on the list, please cc: boehm@mlab.at

