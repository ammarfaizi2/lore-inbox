Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVAGUaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVAGUaB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVAGU3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:29:33 -0500
Received: from mail.joq.us ([67.65.12.105]:455 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261589AbVAGU0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:26:13 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andreas Steinmetz <ast@domdv.de>,
       Lee Revell <rlrevell@joe-job.com>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LAD mailing list <linux-audio-dev@music.columbia.edu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1104374603.9732.32.camel@krustophenia.net>
	<20050103140359.GA19976@infradead.org>
	<1104862614.8255.1.camel@krustophenia.net>
	<20050104182010.GA15254@infradead.org>
	<1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de>
	<1104898693.24187.162.camel@localhost.localdomain>
	<20050107011820.GC2995@waste.org> <87brc17pj6.fsf@sulphur.joq.us>
	<20050107200245.GW2940@waste.org>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 07 Jan 2005 14:27:26 -0600
In-Reply-To: <20050107200245.GW2940@waste.org> (Matt Mackall's message of
 "Fri, 7 Jan 2005 12:02:46 -0800")
Message-ID: <87mzvl56j5.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> On Thu, Jan 06, 2005 at 11:54:05PM -0600, Jack O'Quin wrote:
>> Note that sched_setschedule() provides no way to handle the mlock()
>> requirement, which cannot be done from another process.
>
> I'm pretty sure that part can be done by a privileged server handing
> out mlocked shared memory segments.

If you're "pretty sure", please explain how locking a shared memory
segment prevents the code and stack of the client's realtime thread
from page faulting.
-- 
  joq
