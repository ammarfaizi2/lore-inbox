Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVATBbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVATBbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 20:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVATBbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 20:31:16 -0500
Received: from mail.joq.us ([67.65.12.105]:7077 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262022AbVATBbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 20:31:14 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 19 Jan 2005 19:32:47 -0600
In-Reply-To: <41EF00ED.4070908@kolivas.org> (Con Kolivas's message of "Thu,
 20 Jan 2005 11:53:01 +1100")
Message-ID: <873bwwga0w.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Con Kolivas wrote:
>
> Here are my results with SCHED_ISO v2 on a pentium-M 1.7Ghz (all
> powersaving features off):
>
> Increasing iso_cpu did not change the results.
>
> At least in my testing on my hardware, v2 is working as advertised. I
> need results from more hardware configurations to know if priority
> support is worth adding or not.

Excellent.  Judging by the DSP Load, your machine seems to run almost
twice as fast as my 1.5GHz Athlon (surprising).  You might want to try
pushing it a bit harder by running more clients (2nd parameter,
default is 20).

Are you getting fairly consistent results running SCHED_ISO
repeatedly?  That worked better for me after I fixed that bug in JACK
0.99.47, but I think there is still more variance than with
SCHED_FIFO.
-- 
  joq
