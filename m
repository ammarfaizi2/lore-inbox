Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVATF64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVATF64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 00:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVATF6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 00:58:55 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:35225 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262059AbVATF6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 00:58:43 -0500
Message-ID: <41EF48BA.50709@kolivas.org>
Date: Thu, 20 Jan 2005 16:59:22 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org> <87oefkd7ew.fsf@sulphur.joq.us>
In-Reply-To: <87oefkd7ew.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> If I look at those png's locally (with gimp or gqview) they have a
> dark grey checkerboard background.  If I look at them on the web (with
> galeon), the background is white.  Go figure.  Maybe the file has no
> background?  I dunno.

Yes there's no background so it depends on what you look at it with. 
Gene already pointed out the checkered background in gimp :)

> I was misreading the x-axis.  They're actually every 20 sec.  My
> system isn't doing that.

Possibly reiserfs journal related. That has larger non-preemptible code 
sections.

> You're really getting hammered with those periodic 6 msec delays,
> though.  The basic audio cycle is only 1.45 msec.

As you've already pointed out, though, they occur even with SCHED_FIFO 
so I'm certain it's an artefact unrelated to cpu scheduling.

Con
