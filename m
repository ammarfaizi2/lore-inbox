Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSJLXqY>; Sat, 12 Oct 2002 19:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbSJLXqX>; Sat, 12 Oct 2002 19:46:23 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:17536 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261376AbSJLXqW> convert rfc822-to-8bit; Sat, 12 Oct 2002 19:46:22 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Benchmark] Contest 0.51
Date: Sun, 13 Oct 2002 09:49:46 +1000
User-Agent: KMail/1.4.3
Cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210130949.52013.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>It seems useful to me add a colum with CPU%+LCPU%.
>It is intersting to notice that 2.5.41 spend 41+9=50% CPU time 
>for compiling and for the io_load while 2.5.42 spend 45+9=54% 
>time. Can I say that 2.5.42 is "better" than 2.5.41 ?

No I'm afraid not. The lcpu% cant estimate accurately the cpu% used by the 
load while the kernel is actually being compiled as the load starts before 
ther kernel compilation and ends after it. This means that lcpu% will always 
overestimate the loads' cpu%. I haven't found a workaround for this... yet

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9qLUdF6dfvkL3i1gRAmS/AJ49q1Kd1RBZU8bflVd2n5RUi1Q3UQCffNZI
8V14Cm2/xbXk/QMCCoBnIf4=
=/fVc
-----END PGP SIGNATURE-----

