Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVAaVFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVAaVFD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVAaVE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:04:56 -0500
Received: from mail.joq.us ([67.65.12.105]:65171 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261368AbVAaVC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:02:57 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Nyberg <alexn@dsv.su.se>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sched - Implement priority and fifo support for
 SCHED_ISO
References: <41F76746.5050801@kolivas.org> <87acqpjuoy.fsf@sulphur.joq.us>
	<41FE9582.7090003@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 31 Jan 2005 15:04:46 -0600
In-Reply-To: <41FE9582.7090003@kolivas.org> (Con Kolivas's message of "Tue,
 01 Feb 2005 07:30:58 +1100")
Message-ID: <87is5dia35.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Jack O'Quin wrote:
>> Loading the realtime-lsm and then running with SCHED_FIFO *does* work
>> as expected on this kernel.  I should retry the test with *exactly*
>> the expected patch sequence.  What would that be?
>
> Sure enough I found the bug in less than 5 mins, and it would
> definitely cause this terrible behaviour.
>
> A silly bracket transposition error on my part :P

Cool.  I'll try that right away.
-- 
  joq
