Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284546AbRLIWQG>; Sun, 9 Dec 2001 17:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284545AbRLIWP4>; Sun, 9 Dec 2001 17:15:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15377 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284546AbRLIWPv>; Sun, 9 Dec 2001 17:15:51 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [OT] fputc vs putc Re: horrible disk thorughput on itanium
Date: 9 Dec 2001 14:15:22 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9v0npq$qn$1@cesium.transmeta.com>
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de> <m1d71pw51p.fsf@frodo.biederman.org> <9uvaqn$u4s$1@cesium.transmeta.com> <20011209141408.A17671@zero>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011209141408.A17671@zero>
By author:    Tom Vier <tmv5@home.com>
In newsgroup: linux.dev.kernel
> 
> according to the putc man page in debian stable, it takes the same args as
> fputc. maybe it varies by glibc version (mine is 2.1.3-19). i guess anyone
> using putc better use autoconf. also, "unix system programming for SVr4"
> says the only difference is that putc is an inlined macro version of fputc.
> 

Nevermind.  I was thinking about putc() and putchar(), additionally
confused by the annoying fact that fputs() is to putc() as puts() is
to putchar()... makes no fscking sense.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
