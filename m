Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310929AbSCMRna>; Wed, 13 Mar 2002 12:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310918AbSCMRnL>; Wed, 13 Mar 2002 12:43:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39685 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310923AbSCMRnI>; Wed, 13 Mar 2002 12:43:08 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5.6: ide driver broken in PIO mode
Date: Wed, 13 Mar 2002 17:41:42 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a6o30m$25j$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0203131339050.26768-100000@serv>
X-Trace: palladium.transmeta.com 1016041366 641 127.0.0.1 (13 Mar 2002 17:42:46 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 13 Mar 2002 17:42:46 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0203131339050.26768-100000@serv>,
Roman Zippel  <zippel@linux-m68k.org> wrote:
>
>I first noticed the problem on my Amiga, but I can reproduce it on an ia32
>machine, when I turn off dma with hdparm.

With PIO, the current IDE/bio stuff doesn't like the write-multiple
interface and has bad interactions. 

Jens, you talked about a patch from Supparna two weeks ago, any
progress?

		Linus
