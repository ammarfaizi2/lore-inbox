Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281270AbRKTSyD>; Tue, 20 Nov 2001 13:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281262AbRKTSxx>; Tue, 20 Nov 2001 13:53:53 -0500
Received: from adsl-63-194-247-216.dsl.lsan03.pacbell.net ([63.194.247.216]:22201
	"EHLO www.vinyltribe.com") by vger.kernel.org with ESMTP
	id <S281225AbRKTSxk>; Tue, 20 Nov 2001 13:53:40 -0500
Subject: 2.4.13 and above causes many "Invalidate: Busy Buffer" messages.
From: Emiliano Garcia <emi@vinyltribe.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 20 Nov 2001 10:51:38 -0800
Message-Id: <1006282299.2189.0.camel@workstation>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



My web server is running software raid 5 on two promise ultra66 cards
with an ALi alladin 5 chipset and a k6-2-500 with 300 megs of ram. The
setup is 2 20 gig Maxtor 5400 RPM drives and one WD 30 gig 7200 rpm
drive.. the raid size is 40 gigs, the chunks are 64kb, and I formated
with stride = 16. 

 I've noticed great improvements in the throughput of my raid with
hdparm -Tt /dev/md0 but now I get "Invalidate: Busy Buffer" hundreds of
times showing up in my dmesg. It only happens under heavy disk I/O and I
really need to figure out if this is just a warning or causing damage. A
dump causes this message to pop up at least 200 times. 

Please advise as to what I need to do to help troubleshoot or what the
fix is.

Emi.

