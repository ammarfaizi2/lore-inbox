Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVAYWZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVAYWZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVAYWYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:24:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:43692 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262180AbVAYWWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:22:08 -0500
Date: Tue, 25 Jan 2005 14:16:30 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <joq@io.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050125141630.F24171@build.pdx.osdl.net>
References: <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us> <20050125083724.GA4812@elte.hu> <87oefdfaxp.fsf@sulphur.joq.us> <20050125214900.GA9421@elte.hu> <20050125135508.A24171@build.pdx.osdl.net> <20050125215758.GA10811@elte.hu> <20050125140302.C24171@build.pdx.osdl.net> <20050125220814.GA11331@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050125220814.GA11331@elte.hu>; from mingo@elte.hu on Tue, Jan 25, 2005 at 11:08:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> But if someone reviewed all of the rlimit use in the kernel, we could
> make it a policy that rlimits might change. Any unsafe use could be made
> safe pretty easily. Since they are ulongs they are updated atomically
> even without any locking - but e.g. the default and the hard limit might
> change separately. (from the viewpoint of rlimit-using kernel code.)

I can wade through them later in the week.

> obviously a remote rlimit must listen to same kind of security
> permissions as e.g. ptrace or signal sending.

Yeah.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
