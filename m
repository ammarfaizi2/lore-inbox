Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135201AbRDLPRR>; Thu, 12 Apr 2001 11:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135202AbRDLPRH>; Thu, 12 Apr 2001 11:17:07 -0400
Received: from mailserver-ng.cs.umbc.edu ([130.85.100.230]:47805 "EHLO
	mailserver-ng.cs.umbc.edu") by vger.kernel.org with ESMTP
	id <S135201AbRDLPQy>; Thu, 12 Apr 2001 11:16:54 -0400
To: linux-kernel@vger.kernel.org
Subject: IDE DMA under 2.4?
From: Ian Soboroff <ian@cs.umbc.edu>
X-Tomato: Polka-dot
Date: 12 Apr 2001 11:16:47 -0400
Message-ID: <87itkaup0g.fsf@danube.cs.umbc.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've noticed that i can't seem to enable DMA on my IDE disk under
2.4.2-ac18.  this works under 2.2.19pre14 (the last 2.2 kernel i
built).  i've been slogging through lk archives but can't seem to find
where this got changed.

when i do 'hdparm -d 1 /dev/hda', i get
/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

my controller is a PIIX4, the disk is an IBM DJSA-220 (2.5" laptop
drive, 20GB).

is there any way to reenable DMA on this disk?  according to 'hdparm
-t -T' while booted single-user, i get about 6MB/s without DMA (under
2.4), and about 17MB/s with (under 2.2).

tia, and sorry if it's a faq i couldn't dig up,
ian

-- 
----
Ian Soboroff                                       ian@cs.umbc.edu
University of MD Baltimore County      http://www.cs.umbc.edu/~ian
