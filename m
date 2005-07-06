Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVGFHuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVGFHuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 03:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVGFHsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 03:48:21 -0400
Received: from math.ut.ee ([193.40.36.2]:8336 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262121AbVGFG1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:27:39 -0400
Date: Wed, 6 Jul 2005 09:27:36 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: ALSA bt87x compile failure in 2.6.13-rc3
Message-ID: <Pine.SOC.4.61.0507060925010.22423@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   CC [M]  sound/pci/bt87x.o
sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
sound/pci/bt87x.c:807: error: `driver' undeclared (first use in this function)
sound/pci/bt87x.c:807: error: (Each undeclared identifier is reported only once
sound/pci/bt87x.c:807: error: for each function it appears in.)
sound/pci/bt87x.c: At top level:
sound/pci/bt87x.c:910: error: `driver' used prior to declaration
make[2]: *** [sound/pci/bt87x.o] Error 1

Substituting driver with pci->driver seems to cure it, it this the 
correct fix?

-- 
Meelis Roos (mroos@linux.ee)
