Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKKBoB>; Fri, 10 Nov 2000 20:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKKBnv>; Fri, 10 Nov 2000 20:43:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23556 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129094AbQKKBnj>; Fri, 10 Nov 2000 20:43:39 -0500
Message-ID: <3A0CA3E9.B51FB18A@transmeta.com>
Date: Fri, 10 Nov 2000 17:42:02 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu> <8uhs7c$2hr$1@cesium.transmeta.com> <20001111023521.D29352@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Actually, what most people expect it to represent is schedulability of
new tasks.  The problem is more one of:

a) Expecting a fixed relationship between the specific number and the
behaviour of the machine;
b) The long time constants.

On an 8-way machine a load average of 16 is not particularly high, even
if you only count runnable processes, for example.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
