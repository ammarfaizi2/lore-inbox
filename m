Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTETEML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 00:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbTETEML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 00:12:11 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:3010 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261262AbTETEMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 00:12:10 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>
	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
	<babhik$sbd$1@cesium.transmeta.com>
	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com>
	<m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com>
	<1053392095.21582.48.camel@imladris.demon.co.uk>
	<3EC9803F.6010701@zytor.com>
	<buoy91275r3.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3EC9AB3F.1090802@zytor.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 20 May 2003 13:24:21 +0900
In-Reply-To: <3EC9AB3F.1090802@zytor.com>
Message-ID: <buoel2u2qkq.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> The kernel-internal headers would typedef these to different names, e.g.
> 
> /* linux/types.h */
> #include <linux/abi/types.h>
> /* Kernel internal types */
> typedef __kernel_dev64_t dev_t;
> typedef __kernel_ino_t ino_t;

I see...  I guess that seems reasonable.

-Miles
-- 
`Cars give people wonderful freedom and increase their opportunities.
 But they also destroy the environment, to an extent so drastic that
 they kill all social life' (from _A Pattern Language_)
