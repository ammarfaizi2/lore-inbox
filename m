Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265116AbSJaCmf>; Wed, 30 Oct 2002 21:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265117AbSJaCmf>; Wed, 30 Oct 2002 21:42:35 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:36108 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265116AbSJaCmd>; Wed, 30 Oct 2002 21:42:33 -0500
Date: Thu, 31 Oct 2002 11:48:32 +0900 (JST)
Message-Id: <20021031.114832.59687399.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: boissiere@adiglobal.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5] October 30, 2002
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021030.143615.10738219.davem@redhat.com>
References: <3DBFB0D2.21734.21E3A6B@localhost>
	<20021031.005535.67557509.yoshfuji@linux-ipv6.org>
	<20021030.143615.10738219.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: ,!^C1nUj;HDn\o}#MDnZW<|oj*]iIB/>/Rj|xZ=D=hBIY#)lQ,$n#kJvDg7at|p;w0^8&4_
 OS17ezZP7m/LlFJYPF}FdcGx!,qBM:w{Ub2#M8_@n^nYT%?u+bwTsqni(z5
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021030.143615.10738219.davem@redhat.com> (at Wed, 30 Oct 2002 14:36:15 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

>      - IPv6 source address selection; which will be mandated by the
>        node requirement.
> 
> We told you several times how this USAGI patch is not currently in an
> acceptable form and needs to be reimplemented via the routing code.

Yes, but I think
  - integrate our code to your tree
then
  - reimplement (re-design)
is better way to go forward.

This is because the code, which works well in O(n) as current one 
does, will tell you our needs and intentions better than our
babble when you re-design it;  I belive we will achieve better 
design in this way.


>      - several enhancements on specification conformity
>        (neighbour discovery etc.)
> 
> Where are these patches?  I've applied everything you've submitted.

Yes, thanks.

I need to check the result of current code and 
to look at diff by byte-to-byte before preparing
patches for current tree.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
