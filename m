Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317668AbSGJXPf>; Wed, 10 Jul 2002 19:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317670AbSGJXPe>; Wed, 10 Jul 2002 19:15:34 -0400
Received: from stephens.ittc.ku.edu ([129.237.125.220]:55425 "EHLO
	stephens.ittc.ku.edu") by vger.kernel.org with ESMTP
	id <S317668AbSGJXPd>; Wed, 10 Jul 2002 19:15:33 -0400
Date: Wed, 10 Jul 2002 18:18:18 -0500 (CDT)
From: Karthikeyan Nathillvar <ntkarthik@ittc.ku.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Process Memory Usage
Message-ID: <Pine.LNX.4.33.0207101811550.4626-100000@plato.ittc.ku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I want to find the memory usage of a particular process, to be precise
the percentage memory utilization. I need to find it through a program
other than "top".

 1) I tried using getrusage() system call. But it is returning zero for
all values(like ru_maxrss, etc..) except ru_utime and ru_stime. I am using
2.2.18 kernel.

 2) I tried to read from /proc/<pid>/statm file. But, the process memory
usage seems to be always in an increasing trend, even though lot of
freeing is going on inside. All the values, size, resident, are always
increasing.

   Can anyone suggest me any other ways through which memory utilization
of a program can be obtained.

Thanking you in advance,
ntk.


