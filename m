Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132998AbRDRELu>; Wed, 18 Apr 2001 00:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133000AbRDRELj>; Wed, 18 Apr 2001 00:11:39 -0400
Received: from rmx441-mta.mail.com ([165.251.48.44]:26101 "EHLO
	rmx441-mta.mail.com") by vger.kernel.org with ESMTP
	id <S132998AbRDREL0>; Wed, 18 Apr 2001 00:11:26 -0400
Message-ID: <382711968.987567085284.JavaMail.root@web114-wra.mail.com>
Date: Wed, 18 Apr 2001 00:11:20 -0400 (EDT)
From: Frank Davis <fdavis112@juno.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-ac9: af_wanpipe.o unresolved symbols
CC: alan@lxorguk.ukuu.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.242.241
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    During the last stage of make modules_install on 2.4.3-ac9, I received the following:
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac9/kernel/net/wanrouter/af_wanpipe.o
depmod: wanpipe_mark_bh
depmod: wanpipe_queue_tq
depmod: wanpipe_find_card

Regards,
Frank

The previous build steps seemed to work without problems:
make mrproper; make config;make dep;make clean;make bzImage;make modules


