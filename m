Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312803AbSDBFxc>; Tue, 2 Apr 2002 00:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312802AbSDBFxW>; Tue, 2 Apr 2002 00:53:22 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:57607
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S312803AbSDBFxH>; Tue, 2 Apr 2002 00:53:07 -0500
Message-Id: <5.1.0.14.2.20020402004442.00b05cd8@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 02 Apr 2002 00:47:41 -0500
To: linux-kernel@vger.kernel.org
From: Stevie O <stevie@qrpff.net>
Subject: 2.5.7 oops & ksymoops 2.4.5 & libbfd.a
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried installing 2.5.7.
After patching the sys_nfsservctl problem, I got everything installed, started to boot it, and it Oopsed ('attempted to kill init!', whee!).

So I went looking for ksymoops, and, lo and behold, it's not with the kernel anymore.

So I downloaded it, tried to compile, and got a bunch of 'undefined reference's from merge.o in libbfd.a.

I googled every possible combination of this, but couldn't find a solution.

How do I get this oops decoded?


--
Stevie-O

Real programmers use
        cat > /bin/ksymoops

