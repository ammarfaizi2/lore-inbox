Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283268AbSAGRfH>; Mon, 7 Jan 2002 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284141AbSAGRe5>; Mon, 7 Jan 2002 12:34:57 -0500
Received: from port-213-20-128-16.reverse.qdsl-home.de ([213.20.128.16]:8976
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S283268AbSAGReo> convert rfc822-to-8bit; Mon, 7 Jan 2002 12:34:44 -0500
Date: Mon, 07 Jan 2002 18:34:04 +0100 (CET)
Message-Id: <20020107.183404.846963381.rene.rebe@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
From: Rene Rebe <rene.rebe@gmx.net>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I tried the sched-O1-2.4.17-C1.patch on a 2.4.17 kernel running on a
UP Athlon-XP with 1466Mhz, 512MB RAM, SiS 735 board and an IBM IDE
disks.

I works (no crashes) including XFree-4.1 and ALSA modules loaded.

But during higher load (normal gcc compilations are enough) my system
gets really unresponsive and my mouse-cursor (USB-mouse, XFree-4.1,
Matrox G450) flickers with ~ 5fps over the screen ... :-((

I'll retry with the D0 patch ;-)

k33p h4ck1n6
  René Rebe

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.

