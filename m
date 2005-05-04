Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVEDLu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVEDLu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 07:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVEDLuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 07:50:55 -0400
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:26885 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP id S261641AbVEDLuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 07:50:39 -0400
Date: Wed, 4 May 2005 13:50:26 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: super speed raid pIII_sse memory access in 2.6.12-rc3-mm2
Message-ID: <20050504115026.GA20674@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my /var/log/messages:

Apr 22 18:39:38 middle kernel: Linux version 2.6.12-rc2-mm3 (jurriaan@middle) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #4 SMP PREEMPT Sat Apr 16 11:54:02 CEST 2005
Apr 22 18:39:38 middle kernel:    pIII_sse  :  3048.000 MB/sec
May  4 08:55:40 middle kernel: Linux version 2.6.12-rc3-mm2 (jurriaan@middle) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #2 SMP PREEMPT Wed May 4 08:47:53 CEST 2005
May  4 08:55:40 middle kernel:    pIII_sse  : 192764.000 MB/sec

Now the i875 chipset should have reasonable memory access speed, but 192
GB/s looks a tiny bit suspect :-)

Jurriaan
-- 
"You want to save them all, ATerafin?" She laughed, and the laugh
was chilling. "Try, try with my blessings." There was no question
whatever to Margret that the words were a curse, meant to cause
pain; they implied certain failure, and the amusement of the
powerful at the pathetic struggles of those doomed to fail.
	Michelle West - The Shining Court
Debian (Unstable) GNU/Linux 2.6.12-rc3-mm2 2x4791 bogomips load 0.64
