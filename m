Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132729AbRDQPyv>; Tue, 17 Apr 2001 11:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRDQPym>; Tue, 17 Apr 2001 11:54:42 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:1031 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S132729AbRDQPy0>; Tue, 17 Apr 2001 11:54:26 -0400
Message-ID: <3ADC672E.5F97BAA9@delusion.de>
Date: Tue, 17 Apr 2001 17:54:22 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Tim Waugh <tim@cyberelk.demon.co.uk>
Subject: Parport fifo stuck when printer out of paper
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When my parport printer runs out of paper and there are still
pending print jobs, the kernel will constantly log the following:

DMA write timed out
parport0: FIFO is stuck
parport0: BUSY timeout (1) in compat_write_block_pio

To me it's pretty pointless to fill dmesg and the logfiles with
this rather harmless but still annoying info.

Can this possibly be handled in a nicer way, so that the kernel
keeps quiet about such minor printer issues?

Regards,
Udo.
