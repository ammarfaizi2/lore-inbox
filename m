Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVATJHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVATJHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 04:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVATJHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 04:07:04 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:13201 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262082AbVATJGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 04:06:55 -0500
Message-ID: <10752.195.245.190.93.1106211979.squirrel@195.245.190.93>
In-Reply-To: <87oefkd7ew.fsf@sulphur.joq.us>
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
    <873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
    <87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>
    <87oefkd7ew.fsf@sulphur.joq.us>
Date: Thu, 20 Jan 2005 09:06:19 -0000 (WET)
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
     scheduling
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Jack O'Quin" <joq@io.com>
Cc: "Con Kolivas" <kernel@kolivas.org>, "linux" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, "CK Kernel" <ck@vds.kolivas.org>,
       "utz" <utz@s2y4n2c.de>, "Andrew Morton" <akpm@osdl.org>,
       alexn@dsv.su.se
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Jan 2005 09:06:54.0556 (UTC) FILETIME=[62FBA1C0:01C4FECF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Jack O'Quin wrote:
>>> Outstanding.  How do you get rid of that checkerboard grey
>>> background in the graphs?
>>
>>> Con Kolivas <kernel@kolivas.org> writes:
>> Funny; that's the script you sent me so... beats me?
>
> It's just one of the many things I don't understand about graphics.
>
> If I look at those png's locally (with gimp or gqview) they have a
> dark grey checkerboard background.  If I look at them on the web (with
> galeon), the background is white.  Go figure.  Maybe the file has no
> background?  I dunno.
>

The PNGs are being generated with transparent background. The checkered
background is just being added as a visual helper artifact (or sort of) on
some graphics viewers (notably the ones which names start with "g" :).

It's in jack_test3_plot.sh where the explicit option to render it
transparent is. Just look for "transparent" and get rid of it, if you like
:)

BTW, as joq has already hinted, I have almost ready here a new test suite
(jack_test4), which features an actual (i.e.audible) audio chain instead
of just CPU eaters, as on the jack_test3 set.

Right now I'm merging the corrections joq handed to me yesterday, and will
post it here later toiday.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

