Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268282AbTAMTdJ>; Mon, 13 Jan 2003 14:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268287AbTAMTdI>; Mon, 13 Jan 2003 14:33:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55819 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268282AbTAMTdB>; Mon, 13 Jan 2003 14:33:01 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux v2.5.57
Date: Mon, 13 Jan 2003 19:40:30 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <avv4ne$ds7$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0301131039050.13791-100000@penguin.transmeta.com>
X-Trace: palladium.transmeta.com 1042486903 22154 127.0.0.1 (13 Jan 2003 19:41:43 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 13 Jan 2003 19:41:43 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0301131039050.13791-100000@penguin.transmeta.com>,
Linus Torvalds  <torvalds@transmeta.com> wrote:
>
>And special mention for Brian Gerst, who figured out and fixed a x86 page
>table initialization fix that would leave old machines unable to boot
>2.5.x.

Actually, I should also mention Mikael Pettersson, who actually debugged
and chased the problem down to the initialization.  Sometimes finding
where the problem happens is harder than fixing it once found. 

(On that same vein, kudos to Derek Atkins for chasing down where the
problems he saw with init started happening.)

		Linus
