Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUF3HOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUF3HOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 03:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUF3HOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 03:14:33 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:55454 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S266573AbUF3HOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 03:14:30 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.7-mm4
Date: Wed, 30 Jun 2004 07:14:29 +0000 (UTC)
Organization: Cistron
Message-ID: <cbtp8l$kko$1@news.cistron.nl>
References: <20040629020417.70717ffe.akpm@osdl.org>
X-Trace: ncc1701.cistron.net 1088579669 21144 62.216.30.38 (30 Jun 2004 07:14:29 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton  <akpm@osdl.org> wrote:
>- Merged support for the 64-bit SuperH architecture
>- Various fixes and updates

Compile on amd64 (debian-pure64) failes for me:

  CC      arch/x86_64/kernel/i8259.o
  CC      arch/x86_64/kernel/ioport.o
  CC      arch/x86_64/kernel/ldt.o
  CC      arch/x86_64/kernel/setup.o
arch/x86_64/kernel/setup.c: In function `copy_edd':
arch/x86_64/kernel/setup.c:415: error: `EDD_MBR_SIGNATURE' undeclared (first use in this function)
arch/x86_64/kernel/setup.c:415: error: (Each undeclared identifier is reported only once
arch/x86_64/kernel/setup.c:415: error: for each function it appears in.)
arch/x86_64/kernel/setup.c:417: error: `EDD_MBR_SIG_NR' undeclared (first use in this function)
make[2]: *** [arch/x86_64/kernel/setup.o] Error 1
make[1]: *** [arch/x86_64/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.7-mm4'
make: *** [stamp-build] Error 2


.config is at http://dth.net/amd64/

Danny


-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -

