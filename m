Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283426AbRK2Wzv>; Thu, 29 Nov 2001 17:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283429AbRK2Wzl>; Thu, 29 Nov 2001 17:55:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:3348 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283426AbRK2Wzi>;
	Thu, 29 Nov 2001 17:55:38 -0500
Date: Thu, 29 Nov 2001 23:55:30 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] ReiserFS on RAID5 Linux-2.4 - speed problem
Message-Id: <20011129235530.08da0d04.rene.rebe@gmx.net>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CAE6@mail0.myrio.com>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CAE6@mail0.myrio.com>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001 13:36:08 -0800
Torrey Hoffman <torrey.hoffman@myrio.com> wrote:

> René Rebe wrote:
> [...]
> > I run ReiserFS on a RAID5 (of 3 IDE disks) using the latest 
> > 2.4.(e.g.16)
> > kernel for weeks. It works well except that is is painfully 
> > slow. 
> [...]
> 
> You are not the only one with these problems...

Have you tryed:

echo 1023 > /proc/sys/vm/max-readahead

(power of 2 -1) found in some -ac or 2.4.16 kernel. I was amazed that
it might accelerated my setup by a factor of 2 ? (I still have
to verify this ...)

[...]

> Happy to help test and debug... please send suggestions.
> 
> Torrey Hoffman
> 



k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #127875 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
