Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132776AbRDQRVI>; Tue, 17 Apr 2001 13:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132784AbRDQRU6>; Tue, 17 Apr 2001 13:20:58 -0400
Received: from pa147.bialystok.sdi.tpnet.pl ([213.25.59.147]:1540 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132776AbRDQRUq>; Tue, 17 Apr 2001 13:20:46 -0400
Date: Tue, 17 Apr 2001 19:19:22 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jp@ulgo.koti.com.pl>
To: linux-kernel@vger.kernel.org
Subject: video performance short raport
Message-ID: <20010417191922.A624@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just downloaded 2.4.3-ac7 to test...

hardware: Voodoo3, VIA MVP3

benchmark: x11perf -putimage100

results:

2.2.19
8000 reps @   0.7785 msec (  1280.0/sec): PutImage 100x100 square

2.4.2-ac20
8000 reps @   0.7736 msec (  1290.0/sec): PutImage 100x100 square

2.4.2-ac27
3600 reps @   1.3980 msec (   715.0/sec): PutImage 100x100 square

2.4.3-ac7
3600 reps @   1.3912 msec (   719.0/sec): PutImage 100x100 square
