Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132797AbRDQRtH>; Tue, 17 Apr 2001 13:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132798AbRDQRs6>; Tue, 17 Apr 2001 13:48:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17168 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132797AbRDQRsp>; Tue, 17 Apr 2001 13:48:45 -0400
Subject: Re: video performance short raport
To: jp@ulgo.koti.com.pl (Jacek =?iso-8859-2?Q?Pop=B3awski?=)
Date: Tue, 17 Apr 2001 18:50:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010417191922.A624@localhost.localdomain> from "Jacek =?iso-8859-2?Q?Pop=B3awski?=" at Apr 17, 2001 07:19:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pZc7-0002qh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hardware: Voodoo3, VIA MVP3
> benchmark: x11perf -putimage100

Interesting because the MVP3 code hasnt been touched for a very long time.
So something between 2.4.2-ac20 and ac27 has done nasties to your 
performance

> 2.4.2-ac20
> 8000 reps @   0.7736 msec (  1290.0/sec): PutImage 100x100 square
> 
> 2.4.2-ac27
> 3600 reps @   1.3980 msec (   715.0/sec): PutImage 100x100 square

Can you find out which one between -ac20 and ac27 it was that changed the
behaviour for me. My first guess is ac21 will show the slow down. If so then
I have a good idea what broke

