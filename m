Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSDTUG3>; Sat, 20 Apr 2002 16:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSDTUGY>; Sat, 20 Apr 2002 16:06:24 -0400
Received: from 216-220-241-232.midmaine.com ([216.220.241.232]:13505 "EHLO
	nic-naa.net") by vger.kernel.org with ESMTP id <S292231AbSDTUGU>;
	Sat, 20 Apr 2002 16:06:20 -0400
Message-Id: <200204202000.g3KK07s07372@nic-naa.net>
To: Dan Aloni <da-x@gmx.net>
cc: dank@kegel.com, linux-kernel@vger.kernel.org, brunner@nic-naa.net
Subject: Re: 32-bit process ids (was: Re: idea to enhance get_pid()) 
In-Reply-To: Your message of "20 Apr 2002 22:12:14 +0300."
             <1019329937.24728.111.camel@callisto.yi.org> 
Date: Sat, 20 Apr 2002 16:00:07 -0400
From: Eric Brunner-Williams in Portland Maine <brunner@nic-naa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> According to the kernel patch made by the people at Cluster
> Infrastructure ( http://ci-linux.sourceforge.net/ ), today 
> it is clear that the upper 16 bits of the pid are used for the node
> number. 

This is the one thing I let through back in 1984. Nixdorff wanted to use
parts of the processID for processorID. Now I don't have my authors' copy
of XPG/1 CAE anymore, but I still have a lasting sense of chagrin that as
trivially exhausted resource as a pid had bits shaved off for mid-80s SMP
machines. Granted, our pid_t of the time was 16 bits, and an Intel HyperCube
made a big dent in the remaining bits-for-pid'ing, and current pid_t's on
32-bit boxen is is 32 bits, and MPP boxes are few and far between -- but
really large clusters are possible.

$.02

Eric


