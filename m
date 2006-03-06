Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWCFRlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWCFRlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCFRlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:41:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25313 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751257AbWCFRlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:41:51 -0500
Date: Mon, 6 Mar 2006 18:41:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>,
       "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060306174122.GA2716@elf.ucw.cz>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com> <20060306125018.GA1673@elf.ucw.cz> <20060306171747.GN21445@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306171747.GN21445@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > Is adding "noapic nolapic" to default command line a big problem?
> 
> For end-users, yes.  People want things to 'just work', not have
> to find arcane commands to type in to make things work.

If distro puts "noapic nolapic" on kernel command line, I'd say users
are unlikely to remove it.. And if they do remove it and it breaks,
they'll only blame themselves...

One more config-option is also not "cheap" (half of users will get it
wrong), and having config-option to change command-line-default seems
wrong to me.

[Well, you could add CONFIG_CMDLINE to i386, like arm has... that
solves more than just this problem...]
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
