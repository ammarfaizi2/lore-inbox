Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSEJG3H>; Fri, 10 May 2002 02:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315816AbSEJG3G>; Fri, 10 May 2002 02:29:06 -0400
Received: from mx0.gmx.de ([213.165.64.100]:6800 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S315779AbSEJG3F>;
	Fri, 10 May 2002 02:29:05 -0400
Date: Fri, 10 May 2002 08:28:55 +0200 (MEST)
From: Michael Kerrisk <m.kerrisk@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Status of capabilities?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005657596@gmx.net
X-Authenticated-IP: [212.224.4.46]
Message-ID: <1035.1021012135@www51.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

What are the current status and future of capabilites?  There seems to be no
up-to-date information on this anywhere.

It seems capabilities have been partly implemented since 2.2.  That is to
say:

1. The kernel checks (effective) capabilities when performing various
operations.

2. System calls are provided to raise and lower capabilties

What's still missing in 2.4, as far as I can see after reading the sources,
is the ability to set capabilities on executable files so that a process
gains those privileges when executing the file.  I recall seeing some information
somewhere saying this wasn't possible / wasn't going to happen for ext2.  Is
it on the drawing board for any file system?  

Thanks

Michael

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

