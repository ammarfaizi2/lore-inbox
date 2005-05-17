Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVEQW0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVEQW0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVEQWXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:23:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:59066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262017AbVEQWQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:16:49 -0400
Date: Tue, 17 May 2005 15:16:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: dev@sw.ru, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup
 and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
Message-Id: <20050517151648.2abff61e.akpm@osdl.org>
In-Reply-To: <293160000.1116338500@[10.10.2.4]>
References: <42822B5F.8040901@sw.ru>
	<768860000.1116282855@flay>
	<42899797.2090702@sw.ru>
	<20050517001542.40e6c6b7.akpm@osdl.org>
	<293160000.1116338500@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <Martin.Bligh@us.ibm.com> wrote:
>
> > So much has changed in there that we might have fixed it by accident, and I
> > do recall a couple of fundamental and subtle NMI bugs being fixed.  So
> > yeah, it might be worth enabling it by default again.  Care to send a patch
> > which does that?
> 
> There are some unfixable machine issues - for instance, the IBM
> Netfinity 8500R corrupts one of the registers (ebx?) every time we get
> an NMI for us, and panics. Probably other boxes you mention above have
> similar issues? But it's not our code that's at fault ...

That sounds like an instant crash.  The problems which were reported a few
years back were different - mysterious lockups after hours or days of
operation.


> In light of this, I don't think it's a good idea to enable NMI by default,
> at least not without a blacklist function of some sort?

OK, thanks - I'll leave things as they stand.
