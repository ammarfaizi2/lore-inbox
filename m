Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVAWEov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVAWEov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVAWEou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:44:50 -0500
Received: from mail.joq.us ([67.65.12.105]:48085 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261219AbVAWEoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:44:44 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>
	<87oefkd7ew.fsf@sulphur.joq.us>
	<10752.195.245.190.93.1106211979.squirrel@195.245.190.93>
	<65352.195.245.190.94.1106240981.squirrel@195.245.190.94>
	<41F19907.2020809@kolivas.org> <87k6q6c7fz.fsf@sulphur.joq.us>
	<41F1F735.1000603@kolivas.org> <41F1F7AF.7000105@kolivas.org>
	<41F1FC1D.10308@kolivas.org> <87wtu55i3x.fsf@sulphur.joq.us>
	<41F2F7C1.70404@kolivas.org> <87r7kcu9tt.fsf@sulphur.joq.us>
	<41F32832.50100@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 22 Jan 2005 22:46:09 -0600
In-Reply-To: <41F32832.50100@kolivas.org> (Con Kolivas's message of "Sun, 23
 Jan 2005 15:29:38 +1100")
Message-ID: <87acr03g8e.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Jack O'Quin wrote:
> [snip lots of valid points]
>> suggest some things to try.  First, make sure the JACK tmp directory
>> is mounted on a tmpfs[1].  Then, try the test with ext2, instead of
>
> Looks like the tmpfs is probably the biggest problem. Here's SCHED_ISO
> with just the /tmp mounted on tmpfs change - running on a complete
> desktop environment with a 2nd exported X seession and my wife
> browsing the net and emailing at the same time.
>
> All invalid runs removed and just this one posted here:
> http://ck.kolivas.org/patches/SCHED_ISO/iso2-benchmarks/
>
> How's that look?

Excellent!  

Sorry I didn't warn you about that problem before.  JACK audio users
generally know about it, but there's no reason you should have.

So, that was run with ext3?
-- 
  joq
