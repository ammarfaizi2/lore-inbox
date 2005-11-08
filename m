Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965337AbVKHHKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965337AbVKHHKq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965375AbVKHHKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:10:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965337AbVKHHKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:10:45 -0500
Date: Mon, 7 Nov 2005 23:10:30 -0800
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/21] Descriptor table fixes / cleanup for i386
Message-ID: <20051108071030.GX7991@shell0.pdx.osdl.net>
References: <200511080417.jA84HiH2009833@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511080417.jA84HiH2009833@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> The core piece of these patches is getting the GDT page aligned;
> I wil rework or deprecate any other pieces of this that are not
> wanted / unnecessary / (hopefully not) buggy.

Rats, I knew this was brewing.  I was about 80% of the way through
rebasing the last set to current git, but there's much redundancy and
clashing.  This set looks a bit nicer than the last one, so I'll rather
go through this one carefully.  Not until after some sleep though.

thanks,
-chris
