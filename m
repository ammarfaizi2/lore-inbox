Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283786AbRLITOb>; Sun, 9 Dec 2001 14:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283803AbRLITOV>; Sun, 9 Dec 2001 14:14:21 -0500
Received: from femail36.sdc1.sfba.home.com ([24.254.60.26]:44287 "EHLO
	femail36.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S283786AbRLITOJ>; Sun, 9 Dec 2001 14:14:09 -0500
Date: Sun, 9 Dec 2001 14:14:08 -0500
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] fputc vs putc Re: horrible disk thorughput on itanium
Message-ID: <20011209141408.A17671@zero>
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de> <20011207.130316.39156883.davem@redhat.com> <20011208201907.A937@zero> <m1d71pw51p.fsf@frodo.biederman.org> <9uvaqn$u4s$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9uvaqn$u4s$1@cesium.transmeta.com>; from hpa@zytor.com on Sun, Dec 09, 2001 at 01:27:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 01:27:51AM -0800, H. Peter Anvin wrote:
> putc() is frequently defined as
> 
> #define putc(__C)   fputc((__C), stdout)
> 
> ... or some equivalent; I think the best way to say it's that it's a
> shorthand.

according to the putc man page in debian stable, it takes the same args as
fputc. maybe it varies by glibc version (mine is 2.1.3-19). i guess anyone
using putc better use autoconf. also, "unix system programming for SVr4"
says the only difference is that putc is an inlined macro version of fputc.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
