Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSBZMyi>; Tue, 26 Feb 2002 07:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSBZMy1>; Tue, 26 Feb 2002 07:54:27 -0500
Received: from AGrenoble-202-1-1-87.abo.wanadoo.fr ([80.14.157.87]:26028 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S284732AbSBZMyO>;
	Tue, 26 Feb 2002 07:54:14 -0500
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18?
Date: 26 Feb 2002 12:54:03 GMT
Organization: Home, Grenoble, France
Message-ID: <a5g0hb$12d$1@lyon.ram.loc>
In-Reply-To: <a5feh2$bvs$1@lyon.ram.loc> <E16fe55-0008UQ-00@the-village.bc.nu>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
In-Reply-To: <E16fe55-0008UQ-00@the-village.bc.nu>
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox <alan@lxorguk.ukuu.org.uk> from ml.linux.kernel:
:> If I can't use the returned value from getsockopt(SO_SNDBUF) to do a
:> setsockopt(SO_SNDBUF), then it's broken!  You'll have a hard time convincing
:> me otherwise.
:
:I'd like to see a standards document cite for that. The behaviour we follow
:is not atypical for a lot of ioctls and syscalls were you ask for one size
:and the kernel gives you its preferred variant. In the other cases I can
:think of the kernel also does not lie about its preferred variant

Practical experience shows that the test program I sent "works" (i.e.
returns the least surprising results) on OpenBSD, HP-UX 11.x. I'm having
a friend testing it for me on Solaris, but my guess is that it will work
there as well.

Raphael
