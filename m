Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273509AbRIUQmv>; Fri, 21 Sep 2001 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273525AbRIUQml>; Fri, 21 Sep 2001 12:42:41 -0400
Received: from CPE-61-9-150-185.vic.bigpond.net.au ([61.9.150.185]:42478 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S273509AbRIUQmj>; Fri, 21 Sep 2001 12:42:39 -0400
Message-ID: <3BAB6CF1.F66B2C30@eyal.emu.id.au>
Date: Sat, 22 Sep 2001 02:38:09 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.10-pre13: strange ps line
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just booted pre13 and I notice this line in ps:

eyal       631  0.0 99.9  8232 4294965340 ?  S    00:41   0:00
/usr/bin/X11/xterm -sb -j -ls -fn 7x14 -geometry 80x80

Also in top:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME
COMMAND
  631 eyal       9   0  5656  -1M   992 S       0  0.0 99.9   0:00 xterm

This is one of a few xterms I have open. Not a special one, it is active
and shows no trouble.

However, the system itself is suffering. It has been a long while since
I last had these long pauses, every minute or so, where everything
freezes. And the machine is practically idle all this time.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
