Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131181AbQKNWdc>; Tue, 14 Nov 2000 17:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbQKNWdW>; Tue, 14 Nov 2000 17:33:22 -0500
Received: from quechua.inka.de ([212.227.14.2]:30066 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131181AbQKNWdK>;
	Tue, 14 Nov 2000 17:33:10 -0500
To: linux-kernel@vger.kernel.org
Subject: for_each_task() in module?
Organization: private Linux site, southern Germany
Date: Tue, 14 Nov 2000 22:37:04 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E13vnlI-0006vs-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of for_each_task() in <linux/sched.h> is based on
init_task. This symbol is exported in Linux 2.2.15 and 2.4.0-test9,
but with a comment which indicates only a special use; it is not
exported in 2.2.9.

Is there an official opinion about whether for_each_task() is intended
to be usable from a module? (Which means the older kernel is simply
buggy) or is the right way to build my own version based on "current"?

Olaf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
