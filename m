Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135186AbRD3K6h>; Mon, 30 Apr 2001 06:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbRD3K62>; Mon, 30 Apr 2001 06:58:28 -0400
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:29328 "EHLO
	mailgate1.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S135198AbRD3K6O>; Mon, 30 Apr 2001 06:58:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Olaf Stetzer <ostetzer@mail.uni-mainz.de>
To: linux-kernel@vger.kernel.org
Subject: make bzlilo seems to ignore non-standard kernel path in lilo.conf (/boot)
Date: Mon, 30 Apr 2001 12:16:24 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01043012162401.00851@Seaborg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when I tried to get rid of the problem I wrote about two days ago in 
this list I compiled the kernel several times but unfortunately it was
not installed correctly by the make target bzlilo.
Is it possible to add a parse of /etc/lilo.conf to this target to look
for the path the compiled kernels are located (in my case it was
/boot but make bzlilo put the new kernel in / so it was not installed
by running lilo afterwards)?
This happened to the last 2.2.x kernels I did not try the 2.4.x
series yet.

Greetings,

Olaf
