Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132194AbRCVVmT>; Thu, 22 Mar 2001 16:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132196AbRCVVmA>; Thu, 22 Mar 2001 16:42:00 -0500
Received: from pa147.bialystok.sdi.tpnet.pl ([213.25.59.147]:2308 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132194AbRCVVly>; Thu, 22 Mar 2001 16:41:54 -0500
Date: Thu, 22 Mar 2001 22:36:08 +0100
From: Jacek Pop³awski <jp@ulgo.koti.com.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac21: aviplay slowdown
Message-ID: <20010322223608.A788@darkwood.tpnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled 2.4.3-pre6 and 2.4.2-ac21 and noticed, that aviplay works
much worse than before. Avifile benchmark told me:

Average video output speed: 20.566223 Mb/s

On 2.2.18 and earlier 2.4.2-ac* it gives 50-55Mb/s.

mtrr is enabled:

[jp@darkwood jp]$ cat /proc/mtrr
reg00: base=0xe8000000 (3712MB), size=  32MB: write-combining, count=2

My hardware: K6-2 500, VIA MVP3, Voodoo3

