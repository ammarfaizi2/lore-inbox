Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTLBRnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTLBRnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:43:25 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:38036 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S262674AbTLBRnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:43:22 -0500
Message-ID: <1070387001.3fcccf39b1f70@horde.sandall.us>
Date: Tue,  2 Dec 2003 09:43:21 -0800
From: Eric Sandall <eric@sandall.us>
To: linux-kernel@vger.kernel.org
Subject: Re: emu10k1 under kernel 2.6?
References: <200312021017.07936.hus@design-d.de>
In-Reply-To: <200312021017.07936.hus@design-d.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 192.168.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heinz Ulrich Stille <hus@design-d.de>:
> Hi!
> 
> I feel I must be missing something obvious, but I just can't get the SB
> Live to work with a 2.6 kernel. The module snd-emu10k1 depends on
> snd-ac97-codec, which doesn't load and says:
> 
> ALSA sound/pci/ac97/ac97_codec.c:1671: AC'97 0:0 does not respond - RESET
> EMU10K1_Audigy: probe of 0000:02:06.0 failed with error -6
> 
> It's working just fine with kernel 2.4. What's wrong now?
> 
> MfG, Ulrich

You have to setup your sound drivers in the kernel now (either OSS or ALSA, the
latter is preferred). I have my SB Live! working on all of the 2.6 kernels
(including the -mm patchsets).

Also, a quick Google search[0] returns at least one page (it shows 10 pages) of
usefull information.

-sandalle

[0] Searching for: AC'97 0:0 does not respond

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
