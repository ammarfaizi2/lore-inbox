Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965389AbVKHHwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965389AbVKHHwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965392AbVKHHwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:52:37 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:10984 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965389AbVKHHwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:52:36 -0500
Date: Tue, 8 Nov 2005 08:52:51 +0100
From: Ingo Molnar <mingo@elte.hu>
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
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/21] Descriptor table fixes / cleanup for i386
Message-ID: <20051108075251.GA28676@elte.hu>
References: <200511080417.jA84HiH2009833@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511080417.jA84HiH2009833@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> Patches to clean up descriptor access in Linux to make it friendly to 
> virtualization environments. [...]

in general these patches look really nice and are a good step forward 
making the i386 arch's segment handling code more unified. Needs good 
-mm exposure first i think.

	Ingo
