Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbRHARWt>; Wed, 1 Aug 2001 13:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbRHARWj>; Wed, 1 Aug 2001 13:22:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7932 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S267635AbRHARWd>; Wed, 1 Aug 2001 13:22:33 -0400
Message-ID: <3B683AC4.E0F2BF9E@mvista.com>
Date: Wed, 01 Aug 2001 10:22:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: No 100 HZ timer !
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just posted a patch on sourceforge:
 http://sourceforge.net/projects/high-res-timers

to the 2.4.7 kernel with both ticked and tick less options, switch able
at any time via a /proc interface.  The system is instrumented with
Andrew Mortons time pegs with a couple of enhancements so you can easily
see your clock/ timer overhead (thanks Andrew).

Please take a look at this system and let me know if a tick less system
is worth further effort.  

The testing I have done seems to indicate a lower overhead on a lightly
loaded system, about the same overhead with some load, and much more
overhead with a heavy load.  To me this seems like the wrong thing to
do.  We would like as nearly a flat overhead to load curve as we can get
and the ticked system seems to be much better in this regard.  Still
there may be applications where this works.

comments?  RESULTS?

George
