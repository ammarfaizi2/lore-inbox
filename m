Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281779AbRLFSFo>; Thu, 6 Dec 2001 13:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281835AbRLFSFf>; Thu, 6 Dec 2001 13:05:35 -0500
Received: from twardziel.tenbit.pl ([195.205.163.235]:26511 "EHLO tenbit.pl")
	by vger.kernel.org with ESMTP id <S281779AbRLFSFT>;
	Thu, 6 Dec 2001 13:05:19 -0500
Date: Thu, 6 Dec 2001 19:04:54 +0100
From: =?iso-8859-2?Q?Mateusz_=A3oskot?= <m.loskot@chello.pl>
To: linux-kernel@vger.kernel.org
Subject: Strange problem with 2.4.x kernel
Message-ID: <20011206190454.B848@cheetah.chello.pl>
Reply-To: m.loskot@chello.pl
Mail-Followup-To: =?iso-8859-2?Q?Mateusz_=A3oskot?= <m.loskot@chello.pl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Os: Linux cheetah 2.4.4 
X-Mailer: MUTT http://www.mutt.org
X-Accept-Language: en pl
X-Location: Europe, Poland, Warsaw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
I'm writing first time to you, so let me say HELLO !

I installed Slackware 8.0 month ago, it is my firewall with NAT (iptables).
I have two kernels: 2.2.19 and 2.4.5 - this is my default kernel.
Everything went fine but three days ago I tried to compile some 2.4.x kernel (2.4.0, 2.4.4, 2.4.5, ...., 2.4.12, 2.4.16).
I went to ftp.kernel.org and got some kernels (zipped and bzipped)
(transfered in BINARY mode, not ASCII).
So the problem is:
When I tried to gunzip or bunzip2 any ftp'd kernel I got terrible ;) message:

invalid compressed data: CRC-ERROR 

...whats going on, I thought...

I know that it is possible to broke archives by ftp'd in ASCII mode, but as I
said I ftp's kernels in BINARY mode, so it isn't the reason.
I have some kernels on cdrom's and I got the same problem during trying gunzip or bunzip2 kernel (2.4.x).
I tested to gunzip or bunzip2 2.2.x kernels 
(from cdrom or ftp'd in binary mode) and everything works fine.
So, it is possible that any 2.4.x kernel is broken ? 
I'm sure that isn't !

So, I tried to find some information about CRC-ERROR's by google, so I found
only that it could be caused by ftp'd archies in ASCII mode.
Other tip was that there could be a problem with CMD640 
chipset/controller etc.
...I'm not so experienced user and I'm very confused ;)))

I found on www.gzip.org some programm writen by Jean-loup Gailly called fixgz
(www.gzip.org/fixgz.c) and some explanation about CRC ERROR's, I tried avery
Gailly's advice but it still doesn't work. I can't gunzip any kernel 2.4.x .

I found in man's that it could be a problem with checksum, so I run sum  
for ftp'd kernel archive and for  the same archive after fixgz'd and sum's 
was really different but fixgz'd doesn't help - doesn't fix these archives.

So, I make every try under my 2.4.5 and 2.2.19 kernel - no positive result.

I haven't any idea where to looking for any bug, any solution, any information how to fix it.

Please, help me and explain what may be broken in my system.
How to try to fix it ?

I'll be very thankful.

Best regards

-- 
Mateusz Loskot
E-mail: m.loskot@chello.pl
GG#: 792434
