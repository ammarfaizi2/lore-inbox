Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279920AbRJ3Lcm>; Tue, 30 Oct 2001 06:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279922AbRJ3Lcc>; Tue, 30 Oct 2001 06:32:32 -0500
Received: from lambik.cc.kuleuven.ac.be ([134.58.10.1]:784 "EHLO
	lambik.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S279920AbRJ3LcT>; Tue, 30 Oct 2001 06:32:19 -0500
Message-Id: <200110301132.MAA22471@lambik.cc.kuleuven.ac.be>
Content-Type: text/plain; charset=US-ASCII
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
To: linux-kernel@vger.kernel.org
Subject: need help interpreting 'free' output.
Date: Tue, 30 Oct 2001 12:32:52 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

since i saw strange things happening with my free memory numbers, i tried 
this:
- i compiled and booted a fresh kernel (no proprietary modules, no patches, 
just 2.4.14-pre4)
- i did free.

bakvis:~# free
             total       used       free     shared    buffers     cached
Mem:        384912      55644     329268          0       3652      29880
-/+ buffers/cache:      22112     362800
Swap:       136512          0     136512

so i have 22 meg used right ?

- i started the daily cron jobs (updatedb and htdig  and some minor things 
like log rotation)

- i did 'free' again.

bakvis:~# free
             total       used       free     shared    buffers     cached
Mem:        384912     377060       7852          0      29424     125660
-/+ buffers/cache:     221976     162936
Swap:       136512        752     135760

so now there is 220 meg used memory right ?
and the memory is definitely used, because as soon as i start a memory hog 
the system hits swap ...

so what am i missing here ?
should i provide more info about my kernel configuration ? vmstat numbers ?

greetings,
Frank
