Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTA0CX4>; Sun, 26 Jan 2003 21:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbTA0CX4>; Sun, 26 Jan 2003 21:23:56 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:9228 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267104AbTA0CXz>; Sun, 26 Jan 2003 21:23:55 -0500
X-WebMail-UserID: rtilley
Date: Sun, 26 Jan 2003 21:33:11 -0500
From: rtilley <rtilley@vt.edu>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00002964
Subject: Re: Hard Disk Failure
Message-ID: <3E3B3FF0@zathras>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> no.  e2fsprogs might cause data loss, but not
> physical damage.

This reminds me of something I read once.

In his book, Takedown, Tsutomu Shimomura (forgive me if that's spelled wrong) 
wrote a few short paragraphs about how he was able to move the head-arm of a 
magnetic disk drive back and forth with software commands. He could tell the 
head-arm to go to any cylinder on the drive, he wondered what would happen if 
he tried to send it to a cylinder that was outside the physical limits of the 
drive. He told the drive (a 200 cylinder drive) to goto cylinder 4000. The 
drive actually tried to go to that cylinder and caused a hardware failure in 
the process.

Is it still possible for software to damage hardware in this fashion or is 
hardware smarter now? Do drives know not to try and access a cylinder that is 
outside their physical limits?


