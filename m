Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbQLLVno>; Tue, 12 Dec 2000 16:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130011AbQLLVne>; Tue, 12 Dec 2000 16:43:34 -0500
Received: from mail.eunet.ch ([146.228.10.7]:51461 "EHLO mail.kpnqwest.ch")
	by vger.kernel.org with ESMTP id <S129557AbQLLVn2>;
	Tue, 12 Dec 2000 16:43:28 -0500
Message-ID: <3A36A2EA.E25C7271@dial.eunet.ch>
Date: Tue, 12 Dec 2000 22:12:58 +0000
From: Mario Vanoni <vanonim@dial.eunet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.2.18 vanilla on SMP, latency WORKAROUND
In-Reply-To: <3A353F65.C471A24@dial.eunet.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Vanoni wrote:
> 
> Same latencies as 2.2.16 and 2.2.17 vanilla,
> over 75 seconds to wait on an other screen!
> And top(1) on a serial VT510 freezes.
> 
> Machine loaded with 2 setiathome and
> Doug Ledford's memtest.
> 
> ASUS P2B-DS Dual PIII550 1024MB memory,
> only SCSI devices (no IDE!).
> 
> Andrea Arcangeli's ..17pre6aa2, ..18pre17aa1
> and ..18pre21aa2 reduced the latency <2 secs.
> 
> Regards
> Mario Vanoni
> 
> PS If necessary, cc, not in lkml!

Patched with Andrea's 2.2.18aa1, with more loads,
latency always minor 1-2 seconds.
Impossible to reproduce 75 seconds!

Mario
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
