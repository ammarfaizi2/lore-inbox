Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVAWCGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVAWCGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 21:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVAWCGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 21:06:50 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:36222 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261185AbVAWCGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 21:06:44 -0500
Message-ID: <41F306B0.7050306@yahoo.com.au>
Date: Sun, 23 Jan 2005 13:06:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
CC: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us>
In-Reply-To: <87hdl940ph.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:

> Chris Wright and Arjan van de Ven have outlined a proposal to address
> the privilege issue using rlimits.  This is still the only workable
> alternative to the realtime LSM on the table.  If the decision were up
> to me, I would choose the simplicity and better security of the LSM.
> But their approach is adequate, if implemented in a timely fashion.  I
> would like to see some progress on this in addition to the scheduler
> work.  People still need SCHED_FIFO for some applications.
> 

I think this is a pretty sane and minimally intrusive (for the kernel)
way to support what you want.

