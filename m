Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbQJaE0V>; Mon, 30 Oct 2000 23:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130201AbQJaE0L>; Mon, 30 Oct 2000 23:26:11 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:60664 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130188AbQJaEZ4>; Mon, 30 Oct 2000 23:25:56 -0500
Message-ID: <39FE49D1.27AABA3F@haque.net>
Date: Mon, 30 Oct 2000 23:25:53 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: caperry@edolnx.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Is IPv4 totally broken in 2.4-test
In-Reply-To: <39FE5C09.F1B13725@edolnx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -f /proc/sys/net/ipv4/tcp_ecn ]
then
        echo "0" >/proc/sys/net/ipv4/tcp_ecn
fi

or dont compile with ECN support int he kernel.

Carl Perry wrote:
> 
> I have test9 running in an original Athlon 500, a PII 300, and a K6-2/400.  All
> of them are experiencing the same problems with networking.  I confimred that
> this is not happening to just my, as my buddy in a far away (California) land is
> experiencing the same thing.  I cannot connect to ubid.com, landsend.com,
> etrade.com, travelocity.com, and a slew of others.  I'm not sure if this is
> because all of those sites are going "Wow!  His IP stack conforms to _STANDARDS_
> - it must be fake" or what.  However, it's really starting to get on my nerves.
> 
> All of the above boxes are based on SuSE 6.4.  Using the latest modutils,
> binutils 2.10, and egcs-1.1.2 (Which I think is still compiler gratas)  My
> buddy's box is a Mandrake 7.1 box.  I know he was using gcc-2.95.2 and an old
> binutils, but he has changed to egcs-1.1.2 and a newer binutils.  He's still
> having the same problem.  I pretty sure it's not an iptables issue, since I
> believe that he has iptables off.  I also tried no tables on my K6-2 box with
> the same effects.
> 
> Is anyone else experiencing these problems?  Does anyone know if certain
> firewalls don't like 2.4 with a passion?  Even better, does anyone know how to
> fix it?
> 
> BTW: I have narrowed this down to a 2.4 problem.  If I load 2.2 on any of those
> machines on the same ISP it doesn't work.
> 
> Any ideas?
> --
>         -Carl Perry
>         caperry@edolnx.net
> 
> "Real programmers don't draw flowcharts.  Flowcharts are, after
> all, the illiterate's form of documentation.  Cavemen drew
> flowcharts; look how much good it did them."
>         -Fortune (The App, not the Magazine)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
