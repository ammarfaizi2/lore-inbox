Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314687AbSDVTny>; Mon, 22 Apr 2002 15:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314688AbSDVTnx>; Mon, 22 Apr 2002 15:43:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314687AbSDVTnw>; Mon, 22 Apr 2002 15:43:52 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: CONFIG_RAMFS in 2.4.19-pre7-ac2 ???
Date: 22 Apr 2002 12:43:41 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aa1p5d$qki$1@cesium.transmeta.com>
In-Reply-To: <3CC1A1EF.AF524412@kegel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3CC1A1EF.AF524412@kegel.com>
By author:    Dan Kegel <dank@kegel.com>
In newsgroup: linux.dev.kernel
> 
> Roy wrote:
> > After upgrading to 2.4.19-pre7-ac2, I can't get CONFIG_RAMFS
> 
> Gee, I hope CONFIG_RAMFS isn't going away.  I need it to
> do loopback mounts of cramfs on an embedded system that
> uses tmpfs as its main filesystem.  (tmpfs doesn't support
> loopback mounts.)
> 

CONFIG_RAMFS is probably going away, but that doesn't mean ramfs is
going away.  At least in Linux 2.5 ramfs will end up being required
core code.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
