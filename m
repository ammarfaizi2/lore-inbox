Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313715AbSDHRvm>; Mon, 8 Apr 2002 13:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313717AbSDHRvl>; Mon, 8 Apr 2002 13:51:41 -0400
Received: from port-213-20-128-213.reverse.qdsl-home.de ([213.20.128.213]:22539
	"EHLO drocklinux.dnydns.org") by vger.kernel.org with ESMTP
	id <S313715AbSDHRvk> convert rfc822-to-8bit; Mon, 8 Apr 2002 13:51:40 -0400
Date: Mon, 08 Apr 2002 19:49:19 +0200 (CEST)
Message-Id: <20020408.194919.596529874.rene.rebe@gmx.net>
To: mark@mark.mielke.cc
Cc: akpm@zip.com.au, rgooch@ras.ucalgary.ca, nahshon@actcom.co.il,
        pavel@suse.cz, bcrl@redhat.com, alan@lxorguk.ukuu.org.uk,
        joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <20020408130849.A30751@mark.mielke.cc>
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On: Mon, 8 Apr 2002 13:08:49 -0400,
    Mark Mielke <mark@mark.mielke.cc> wrote:
> Not really thinking about how hard it would be to implement, I suggest
> that the appropriate place for this to be, would be a mount option.
> 
> Just as 'noatime', or 'sync', perhaps a 'delaywrite' option would be a
> good choice. An advantage of this approach, is that I could make /tmp
> be 'delaywrite+journal' in an effort to improve the efficiency of
> /tmp, as I could care less what I lost in /tmp between reboots under
> extreme situations.

Normally /tmp gets "rm -rf"ed in most dists startup scripts
anyway. /var is for local state data ...

But I also would like such options to make power-saving on Laptops
easier (But I would use it for all partitions ...). I also tried to
make my disks spin-down - but I never got this to work nicely (disks
run far too often). Stuff like delayed write would be really nice.

> mark

k33p h4ck1n6
  René

--  
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.

