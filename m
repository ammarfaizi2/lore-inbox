Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVATCoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVATCoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVATCoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:44:39 -0500
Received: from mail.joq.us ([67.65.12.105]:49057 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261835AbVATCoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:44:34 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 19 Jan 2005 20:45:51 -0600
In-Reply-To: <41EF123D.703@kolivas.org> (Con Kolivas's message of "Thu, 20
 Jan 2005 13:06:53 +1100")
Message-ID: <87ekgges2o.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Jack O'Quin wrote:
>> Excellent.  Judging by the DSP Load, your machine seems to run almost
>> twice as fast as my 1.5GHz Athlon (surprising).  You might want to try
>
> Not really surprising; the 2Mb cache makes this a damn fine cpu, if
> not necessarily across the board :)

I wonder if most of the critical DSP cycle fits in the cache?

Does it degrade significantly with a compile running in the background?

> Full results and pretty pictures available here:
> http://ck.kolivas.org/patches/SCHED_ISO/iso2-benchmarks/

Outstanding.  

How do you get rid of that checkerboard grey background in the graphs?

Looking at the graphs, your system has a substantial 4 to 6 msec delay
on approximately 40 second intervals, regardless of which scheduling
class or how many clients you run.  I'm guessing this is a recurring
long code path in the kernel and not a scheduling artifact at all.
-- 
  joq
