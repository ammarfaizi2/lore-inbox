Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281184AbRK3XcK>; Fri, 30 Nov 2001 18:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281192AbRK3Xb5>; Fri, 30 Nov 2001 18:31:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56583 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281191AbRK3Xbf>; Fri, 30 Nov 2001 18:31:35 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] smarter atime updates
Date: 30 Nov 2001 15:31:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9u94s6$er5$1@cesium.transmeta.com>
In-Reply-To: <20011130145223.Q15936@lynx.no> <Pine.LNX.4.33.0111301349230.1185-100000@penguin.transmeta.com> <20011130143011.A20179@netnation.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011130143011.A20179@netnation.com>
By author:    Simon Kirby <sim@netnation.com>
In newsgroup: linux.dev.kernel
> 
> I've always thought filesystems should mount with noatime,nodiratime by
> default and only actually update atime if specifically mounted with
> "atime", as it's so rarely used.  Out of all of the servers here, none
> actually use atime (every file system on _every_ server is mounted
> noatime,nodiratime).  It's such a waste and just sounds fundamentally
> broken to issue a write because somebody read from a file.
> 
> ...But there's probably some POSIX standard which would make such a
> change illegal.  Blah blah...
> 
> (Not to say that atime isn't useful, but in most cases where it might be
> useful, it is so easily broken by backup processes, etc., that it really
> wants to be a different sort of mechanism.)
> 

Edit /etc/fstab and be happy.  I'm sorry, but you even know why your
request is unacceptable.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
