Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbTIIMGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTIIMGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:06:35 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:25328
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264074AbTIIMGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:06:34 -0400
Message-ID: <3F5DC247.794DD843@eyal.emu.id.au>
Date: Tue, 09 Sep 2003 22:06:31 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: CONFIG_COSA build fails
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

makeallmods, i386:

  CC [M]  drivers/net/wan/cosa.o
drivers/net/wan/cosa.c: In function `cosa_ioctl_common':
drivers/net/wan/cosa.c:1167: parse error before `['
drivers/net/wan/cosa.c:1167: case label does not reduce to an integer
constant
drivers/net/wan/cosa.c:1171: parse error before `['
drivers/net/wan/cosa.c:1171: case label does not reduce to an integer
constant
drivers/net/wan/cosa.c:1175: parse error before `['
drivers/net/wan/cosa.c:1175: case label does not reduce to an integer
constant
drivers/net/wan/cosa.c:1179: parse error before `['
drivers/net/wan/cosa.c:1179: case label does not reduce to an integer
constant
drivers/net/wan/cosa.c:1181: parse error before `['
drivers/net/wan/cosa.c:1181: case label does not reduce to an integer
constant
drivers/net/wan/cosa.c:1187: parse error before `['
drivers/net/wan/cosa.c:1187: case label does not reduce to an integer
constant
make[3]: *** [drivers/net/wan/cosa.o] Error 1
make[2]: *** [drivers/net/wan] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
