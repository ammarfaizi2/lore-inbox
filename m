Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVBCDzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVBCDzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 22:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVBCDzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 22:55:36 -0500
Received: from mail.joq.us ([67.65.12.105]:53157 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262353AbVBCDz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 22:55:27 -0500
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200502022303.j12N3nZa002055@localhost.localdomain>
	<42016661.80908@bigpond.net.au> <87d5viigyo.fsf@sulphur.joq.us>
	<42019633.80803@bigpond.net.au>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 02 Feb 2005 21:56:02 -0600
In-Reply-To: <42019633.80803@bigpond.net.au> (Peter Williams's message of
 "Thu, 03 Feb 2005 14:10:43 +1100")
Message-ID: <878y66wb3h.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Jack O'Quin wrote:
>> Temporarily dropping privileges gains no security whatsoever.  It is
>> nothing more than a coding convenience.

Peter Williams <pwil3058@bigpond.net.au> writes:
> Yes, to help avoid accidentally misusing the privileges.

>> The program remains *inside* the system security perimeter.
>
> Which is why you have to be careful in writing setuid programs.

Which is why I'd rather not run an inherently insecure program like
jackd with root privileges.  

I can live with a cracker crashing my audio workstation with a DoS
attack using realtime privileges.  I'll just have to reboot.  But, I
do not want him turning my mail server into a spam relay.
-- 
  joq
