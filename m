Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVASFax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVASFax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVASFax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:30:53 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:24710 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261590AbVASFai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:30:38 -0500
Message-ID: <41EDF0B2.9090006@kolivas.org>
Date: Wed, 19 Jan 2005 16:31:30 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: utz <utz@s2y4n2c.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org> <1106112369.3956.7.camel@segv.aura.of.mankind>
In-Reply-To: <1106112369.3956.7.camel@segv.aura.of.mankind>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

utz wrote:
> Hi Con
> 
> I just played with your SCHED_ISO patch and found a simple way to crash
> my machine.
> 
> I'm running this as unprivileged user with SCHED_ISO:
> 
> main ()
> {
>         while(1) {
>                 sched_yield();
>         }
> }
> 
> The system hangs about 3s and then reboots itself.
> 2.6.11-rc1 + 2.6.11-rc1-iso-0501182249 on an UP Athlon XP.
> 
> With real SCHED_FIFO it just lockup the system.

Thanks I'll look into it.

Cheers,
Con
