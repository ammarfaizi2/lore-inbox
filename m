Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVAVGRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVAVGRX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 01:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVAVGRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 01:17:23 -0500
Received: from mail.joq.us ([67.65.12.105]:54661 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262562AbVAVGRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 01:17:20 -0500
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
	<41F19907.2020809@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 22 Jan 2005 00:18:56 -0600
In-Reply-To: <41F19907.2020809@kolivas.org> (Con Kolivas's message of "Sat,
 22 Jan 2005 11:06:31 +1100")
Message-ID: <87k6q6c7fz.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Here's fresh results on more stressed hardware (on ext3) with
> 2.6.11-rc1-mm2 (which by the way has SCHED_ISO v2 included). The load
> hovering at 50% spikes at times close to 70 which tests the behaviour
> under iso throttling.

What version of JACK are you running (`jackd --version')?

You're still getting zero Delay Max.  That is an important measure.
-- 
  joq
