Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131101AbRBMNi7>; Tue, 13 Feb 2001 08:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbRBMNit>; Tue, 13 Feb 2001 08:38:49 -0500
Received: from mail.ansp.br ([143.108.25.7]:42001 "HELO www.ansp.br")
	by vger.kernel.org with SMTP id <S131101AbRBMNij>;
	Tue, 13 Feb 2001 08:38:39 -0500
Message-ID: <3A892AC4.1BE7B4F1@ansp.br>
Date: Tue, 13 Feb 2001 10:38:28 -0200
From: Marcus Ramos <marcus@ansp.br>
Organization: Fapesp
X-Mailer: Mozilla 4.73 [en] (X11; I; FreeBSD 4.1-RELEASE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with kernel-module version mismatch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After compiling files "ttime.c" and "ttime.h", I try to load them into
the kernel using the command /sbin/insmod ttime.o. However, the
following message suggests that a version conflict  has prevented the
loading to be performed correctly:

"kernel-module version mismatch. ttime.o was compiled for kernel
2.4.0-0.26 while this kernel is version 2.2.16-22".

My question is: since the source has been compiled on the same kernel as
it is going to be loaded into, how come this message ? What do I have to
do in order to avoid such problem ? Change the source code ? Where did
it learn about 2.4.0-0.26 if I am using 2.2.16-22 (Red Hat 7.0) ?

Thanks in advance,
Marcus.



