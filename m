Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbRHMU37>; Mon, 13 Aug 2001 16:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRHMU3t>; Mon, 13 Aug 2001 16:29:49 -0400
Received: from [212.6.122.14] ([212.6.122.14]:25764 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id <S267997AbRHMU3e>;
	Mon, 13 Aug 2001 16:29:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Herbert U. =?iso-8859-1?q?H=FCbner?=" 
	<herbert-u-.huebner@webave.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.8 - EMU10K1 - Kernel Compile Breaks in Module main.o
Date: Mon, 13 Aug 2001 22:29:50 +0200
X-Mailer: KMail [version 1.2]
Cc: rsousa@grad.physics.sunysb.edu
MIME-Version: 1.0
Message-Id: <01081322295000.01135@gotcha.friendglow.net>
Content-Transfer-Encoding: 7BIT
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
Kernel compilation breaks with message
main.o(.modinfo+0x40): multiple definition of `__module_author'

Problem fix:
Delete the /usr/src/linux/drivers/sound/emu10k1 tree and copy the tree of 
kernel 2.4.7 into 2.4.8. Then it works.

Error Correction:
Please, review the changes made to emu10k1 by Robert Love announced in 
Changelog-2.4.8 under "final:"

Configuration file used for kernel compilation:
see attached text file "config.emu10k".
The contents of the config file has not changed since kernel 2.4.5 and worked 
for 2.4.6 and 2.4.7.

Error log (make modules):
see attached text file "module_emu10k.txt"

Thanks for your kind attention to this matter.

Regards
Herbert U. Huebner <herbert-u-.huebner@webave.com>
