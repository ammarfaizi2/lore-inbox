Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTFBFmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 01:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTFBFmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 01:42:21 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:44786 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261893AbTFBFmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 01:42:20 -0400
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
From: Martin Schlemmer <azarah@gentoo.org>
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200306011136.27211.kde@myrealbox.com>
References: <3ED8D5E4.6030107@cox.net>
	 <200306010016.05548.kde@myrealbox.com> <3ED93CC6.30200@cox.net>
	 <200306011136.27211.kde@myrealbox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054532617.5270.4.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 02 Jun 2003 07:43:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 10:36, ismail (cartman) donmez wrote:
> On Sunday 01 June 2003 02:37, Kevin P. Fleming wrote:
> > Oh, I saw that discussion. I fully agree. If I can help the process of
> > creating a sanitized userspace set of kernel headers I'll be happy to.
> >

Well, Redhat do have "sanitized kernel headers", but according to the
whole thread about glibc being broken, it is not the preferred solution.

The solution is to have a set of API headers that userspace can use,
and that the kernel headers in turn include.

Problem now (as usual), is that even though I and a few others did
offer to help or organise help if one kernel hacker is willing to take
the lead, nobody responded, so I guess we will not see this any time
soon.

> > In the meantime, a small change to a kernel header, that provides _zero_
> > functional difference to the kernel itself (it's only there for source
> > code checkers, as best I can tell) shouldn't break existing userspace
> > libraries.
> Fully ACK.
> 

Same here, as the "solution" will not be seen any time soon :/


Regards,

-- 
Martin Schlemmer


