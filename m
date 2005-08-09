Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVHIVGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVHIVGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVHIVGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:06:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964969AbVHIVGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:06:19 -0400
Date: Tue, 9 Aug 2005 14:06:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
Subject: Re: [PATCH] Fix i386 signal handling of NODEFER, should not affect sa_mask (was: Re: Signal handling possibly wrong)
Message-ID: <20050809210606.GX7762@shell0.pdx.osdl.net>
References: <42F8F6CC.7090709@fujitsu-siemens.com> <1123612789.3167.9.camel@localhost.localdomain> <42F8F98B.3080908@fujitsu-siemens.com> <1123614253.3167.18.camel@localhost.localdomain> <1123615983.18332.194.camel@localhost.localdomain> <42F906EB.6060106@fujitsu-siemens.com> <1123617812.18332.199.camel@localhost.localdomain> <1123618745.18332.204.camel@localhost.localdomain> <20050809204928.GH7991@shell0.pdx.osdl.net> <1123621223.9553.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123621223.9553.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> Hmm, I think you want this patch. You still need to check the return of
> setting up the frames.

Indeed, I noticecd just after I sent, and sent an updated patch.
Thanks Steve!
