Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVAYWcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVAYWcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVAYW3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:29:50 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:51279 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262207AbVAYW26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:28:58 -0500
Message-ID: <60892.192.168.1.5.1106686326.squirrel@192.168.1.5>
In-Reply-To: <87k6q1nynx.fsf@sulphur.joq.us>
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
    <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
    <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
    <87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>
    <877jm3ljo9.fsf@sulphur.joq.us> <41F44AC2.1080609@kolivas.org>
    <87hdl7v3ik.fsf@sulphur.joq.us> <87651nv356.fsf@sulphur.joq.us>
    <87ekgbqr2a.fsf@sulphur.joq.us> <41F49735.5000400@kolivas.org>
    <873bwrpb4o.fsf@sulphur.joq.us> <41F57D94.4010500@kolivas.org>
    <41F5C347.4030605@kolivas.org> <41F64410.4000702@kolivas.org>
    <87k6q1nynx.fsf@sulphur.joq.us>
Date: Tue, 25 Jan 2005 20:52:06 -0000 (WET)
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
     scheduling
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Jack O'Quin" <joq@io.com>
Cc: "Con Kolivas" <kernel@kolivas.org>, "Alexander Nyberg" <alexn@dsv.su.se>,
       "Ingo Molnar" <mingo@elte.hu>, "linux" <linux-kernel@vger.kernel.org>,
       "CK Kernel" <ck@vds.kolivas.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 25 Jan 2005 22:28:50.0569 (UTC) FILETIME=[3E6D4F90:01C5032D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
>
> If you grep your log file for 'client failure:', you'll probably find
> that JACK has reacted to the deteriorating situation by shutting down
> some of its clients.  The number of 'client failure:' messages is
> *not* the number of clients shut down, there is some repetition (not
> sure why).  This will give the actual number...
>
>   $ grep '^client failure:' ${LOGFILE} | cut -f4 -d' ' | sort -u | wc -l
>
> It would help if the test script reported this value.
>

I will include it on the next jack_test4.2 :)
If you remember of anything else, please ask.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

P.S. I'm under a terrible cold|flu right now #( that's why I didn't had
the time or patience to test all these new kernel iso/rt_cpu_limit
goodies. So sorry.


