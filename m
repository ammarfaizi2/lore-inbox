Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTKGWsC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTKGWpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:45:44 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:39075 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S262015AbTKGWoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 17:44:13 -0500
Message-ID: <1068245051.3fac203b9eec3@horde.sandall.us>
Date: Fri,  7 Nov 2003 14:44:11 -0800
From: Eric Sandall <eric@sandall.us>
To: Brandon Stewart <rbrandonstewart@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Bob Gill <gillb4@telusplanet.net>
Subject: Re: 2.6.0-test9-mm1 and mm2: Extremely slow mouse
References: <20031107044652.2325.qmail@web20903.mail.yahoo.com>
In-Reply-To: <20031107044652.2325.qmail@web20903.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 192.168.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brandon Stewart <rbrandonstewart@yahoo.com>:
> Simple solution. Add psmouse_resolution=200 to the boot options. No skip,
> smooth mouse. All is good.
> 
> image=/boot/vmlinuz-2.6.0-test9-mm2
>         label=260-test9-mm2
>         root=/dev/hda5
>         read-only
>         append=" devfs=mount acpi=on resume=/dev/hda1
> psmouse_resolution=200"
>         initrd=/boot/initrd-2.6.0-test9-mm2.img
> 
> -Brandon

I tried that, and my mouse was still slow.

-sandalle

--
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
