Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTBDDaD>; Mon, 3 Feb 2003 22:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267117AbTBDDaD>; Mon, 3 Feb 2003 22:30:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18694 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267107AbTBDDaC>; Mon, 3 Feb 2003 22:30:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Compactflash cards dying?
Date: 3 Feb 2003 19:39:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b1ncl3$rfm$1@cesium.transmeta.com>
References: <20030202223009.GA344@elf.ucw.cz> <20030203073028.B4C2920BD9@dungeon.inka.de> <20030203125449.GB480@elf.ucw.cz> <1044313953.28406.44.camel@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1044313953.28406.44.camel@imladris.demon.co.uk>
By author:    David Woodhouse <dwmw2@infradead.org>
In newsgroup: linux.dev.kernel
> 
> So use a pseudo-file-system which lets you store 8-bit data on such a
> device storing only 7-bit data. 
> 
> It's no less sensible than taking a real flash device and hacking up a
> pseudo-file-system which makes it pretend to be a block device, then
> using a 'normal' file system on top of that. 
> 
> It's just a shame that CF doesn't generally give you real access to the
> underlying flash and let you use a real file system designed for the
> purpose rather than its silly 'translation layer' :)
> 

Well, it also let them implement the translation layer using a
different storage device, which may be more appropriate for the task,
or by playing other hardware-specific games.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
