Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280909AbRKTEv1>; Mon, 19 Nov 2001 23:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280911AbRKTEvR>; Mon, 19 Nov 2001 23:51:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36869 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280909AbRKTEvF>; Mon, 19 Nov 2001 23:51:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux can use a mountpoint for 2 Filesystems
Date: 19 Nov 2001 20:50:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tcnfg$57m$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10111191938450.12291-100000@master.linux-ide.org> <Pine.LNX.4.10.10111191939290.12141-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10111191939290.12141-100000@master.linux-ide.org>
By author:    Andre Hedrick <andre@linux-ide.org>
In newsgroup: linux.dev.kernel
> 
> Greetings Gernot,
> 
> You can do this with all real and virtual spindles under Linux.
> The reality is total crap that it can happen, but what the hey ...
> No policies in UNIX, ROOT beware.
> 
> Sorry, but this report saddens me, issues like these are permitted
> There are no kernel controls to prevent multi mounting to the same point.
> 

There are real reasons to overmount a filesystem.  It's getting to be
a usability problem, probably because Linux (UNLIKE MOST OTHER UNIXES)
didn't allow it until just recently.  This change caused some
problems, including with the automount daemon.  I would like to see an
option to mount(8) to allow it, by default disallow by policy.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
