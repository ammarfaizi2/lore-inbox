Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRDCJm2>; Tue, 3 Apr 2001 05:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDCJmJ>; Tue, 3 Apr 2001 05:42:09 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:28429 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129524AbRDCJmC>; Tue, 3 Apr 2001 05:42:02 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Tue, 3 Apr 2001 11:40:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: pthreads & gdb: zombie threads?
Message-ID: <3AC9B6C7.18590.CCCBA1@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having a strange problem debugging a pthreads application in 2.2.18 
(as per SuSE 7.1):

gdb says the program terminated normally after having started two or 
three LWPs. I can exit gdb then, and I find (ps -ax) one zombie thread 
and two or three other threads. Is it more likely a kernel problem, a 
library problem, or a gdb problem?

Naively I thought when exiting the process, all threads would die...

Ulrich
P.S. Not subscribed here

