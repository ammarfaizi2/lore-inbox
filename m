Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKKBsV>; Fri, 10 Nov 2000 20:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129322AbQKKBsL>; Fri, 10 Nov 2000 20:48:11 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:38815 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129166AbQKKBsB>; Fri, 10 Nov 2000 20:48:01 -0500
Message-ID: <3A0CA547.E9259929@haque.net>
Date: Fri, 10 Nov 2000 20:47:51 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu> <8uhs7c$2hr$1@cesium.transmeta.com> <20001111023521.D29352@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this exact argument at work every so often. People coming in from
an NT environment have difficulty understanding what it is/means and
that it's not neccessarily bad when load gets above 1, etc, etc, etc.

Ralf Baechle wrote:
> 
> On Fri, Nov 10, 2000 at 02:18:20PM -0800, H. Peter Anvin wrote:
> 
> > Numerically high load averages aren't inherently a bad thing.  There
> > isn't anything bad about a system with a loadavg of 20 if it does what
> > it should in the time you'd expect.  However, if your daemons start
> > blocking because they assume this number means badness, than that is
> > the problem, not the loadavg in itself.
> 
> The problem seems to me that the load figure doesn't express what most
> people seem to expect it to - CPU load.
> 
>   Ralf

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
