Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272448AbRIFLG6>; Thu, 6 Sep 2001 07:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272449AbRIFLGs>; Thu, 6 Sep 2001 07:06:48 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:42513 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S272448AbRIFLGb>; Thu, 6 Sep 2001 07:06:31 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200109061105.f86B5o110740@wildsau.idv-edu.uni-linz.ac.at>
Subject: errors in tcp.h
To: linux-kernel@vger.kernel.org
Date: Thu, 6 Sep 2001 13:05:50 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/root/linux-2.4.9/include/net/tcp.h:922:72: macro "min" passed 3 arguments, but takes just 2
In file included from slhc.c:75:
/root/linux-2.4.9/include/net/tcp.h: In function `tcp_initialize_rcv_mss':
/root/linux-2.4.9/include/net/tcp.h:922: `min' undeclared (first use in this function)
/root/linux-2.4.9/include/net/tcp.h:922: (Each undeclared identifier is reported only once
/root/linux-2.4.9/include/net/tcp.h:922: for each function it appears in.)
/root/linux-2.4.9/include/net/tcp.h:924:53: macro "min" passed 3 arguments, but takes just 2
/root/linux-2.4.9/include/net/tcp.h:926: warning: implicit declaration of function `max'
/root/linux-2.4.9/include/net/tcp.h:926: parse error before "unsigned"
/root/linux-2.4.9/include/net/tcp.h:928:55: macro "min" passed 3 arguments, but takes just 2
In file included from slhc.c:75:
/root/linux-2.4.9/include/net/tcp.h: In function `tcp_recalc_ssthresh':
/root/linux-2.4.9/include/net/tcp.h:1080: parse error before "u32"
/root/linux-2.4.9/include/net/tcp.h: In function `tcp_current_ssthresh':
/root/linux-2.4.9/include/net/tcp.h:1092: parse error before "u32"
In file included from slhc.c:75:
/root/linux-2.4.9/include/net/tcp.h:1130:57: macro "min" passed 3 arguments, but takes just 2
/root/linux-2.4.9/include/net/tcp.h: In function `__tcp_enter_cwr':
/root/linux-2.4.9/include/net/tcp.h:1130: `min' undeclared (first use in this function)
/root/linux-2.4.9/include/net/tcp.h:1496:46: macro "min" passed 3 arguments, but takes just 2
/root/linux-2.4.9/include/net/tcp.h: In function `tcp_select_initial_window':
/root/linux-2.4.9/include/net/tcp.h:1496: `min' undeclared (first use in this function)
/root/linux-2.4.9/include/net/tcp.h:1508:52: macro "min" passed 3 arguments, but takes just 2
/root/linux-2.4.9/include/net/tcp.h:1517: parse error before "unsigned"
/root/linux-2.4.9/include/net/tcp.h:1535:73: macro "min" passed 3 arguments, but takes just 2
/root/linux-2.4.9/include/net/tcp.h:1701:68: macro "min" passed 3 arguments, but takes just 2
/root/linux-2.4.9/include/net/tcp.h: In function `tcp_moderate_sndbuf':
/root/linux-2.4.9/include/net/tcp.h:1701: `min' undeclared (first use in this function)
/root/linux-2.4.9/include/net/tcp.h:1702: parse error before "int"
make[3]: *** [slhc.o] Error 1
make[3]: Leaving directory `/root/linux-2.4.9/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/root/linux-2.4.9/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/root/linux-2.4.9/drivers'
make: *** [_dir_drivers] Error 2


I know how to fix it, but hey ...
those new macros surely do a good job
in fixing all those nasty bugs.

