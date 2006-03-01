Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWCAWRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWCAWRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWCAWRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:17:35 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47747 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751308AbWCAWRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:17:34 -0500
Date: Wed, 1 Mar 2006 14:19:54 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ashok Raj <ashok.raj@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [patch 10/39] [PATCH] i386/x86-64: Dont IPI to offline cpus on shutdown
Message-ID: <20060301221954.GQ3883@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org> <20060227223344.160102000@sorel.sous-sol.org> <200602272337.56509.ak@suse.de> <20060227231814.GN3883@sorel.sous-sol.org> <m1r75ot192.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r75ot192.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman (ebiederm@xmission.com) wrote:
> The comprehensive fix for 2.6.15.x is to remove -p from /sbin/halt
> if your machine has this problem.  I have just updated the bugzilla
> entry so we can remember this.

fix...workaround... ;-)  At any rate, I've dropped this one.  Thanks
to you and Andi for reviewing.

thanks,
-chris
