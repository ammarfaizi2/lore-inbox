Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281463AbRKMESL>; Mon, 12 Nov 2001 23:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281464AbRKMESB>; Mon, 12 Nov 2001 23:18:01 -0500
Received: from mail209.mail.bellsouth.net ([205.152.58.149]:40983 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281463AbRKMERq>; Mon, 12 Nov 2001 23:17:46 -0500
Message-ID: <3BF09ED5.54176F4F@mandrakesoft.com>
Date: Mon, 12 Nov 2001 23:17:25 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Donald Maner <donjr@maner.org>
CC: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Compile error 2.4.15-pre4 on alpha
In-Reply-To: <C033B4C3E96AF74A89582654DEC664DB5576@aruba.maner.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Maner wrote:
> Hello, I'm compiling on a PC164SX, and I'm getting this at the end.  I'm
> pretty sure the math stuff doesn't have anything to do w/ it, but just
> incase:
[...]
> fs/fs.o: In function `cpuinfo_open':
> fs/fs.o(.text+0x2cf88): undefined reference to `cpuinfo_op'
> make: *** [vmlinux] Error 1

looks like alpha needs to implement /proc/cpuinfo as seqfile, as Linus
said.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

