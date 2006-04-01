Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWDASy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWDASy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 13:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWDASy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 13:54:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62162 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750744AbWDASy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 13:54:29 -0500
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about __ARCH_WANT_SYS_GETHOSTNAME
References: <Pine.LNX.4.58.0603310911260.6105@shark.he.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 01 Apr 2006 11:53:26 -0700
In-Reply-To: <Pine.LNX.4.58.0603310911260.6105@shark.he.net> (Randy Dunlap's
 message of "Fri, 31 Mar 2006 09:21:43 -0800 (PST)")
Message-ID: <m1slox86vt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> Hi,
>
> What was/is the purpose of __ARCH_WANT_SYS_GETHOSTNAME?
> and why do a few arches not #define it?
>
> If it is not #defined, should those arches supply their own
> sys_gethostname() function?
>
> 21 arches #define __ARCH_WANT_SYS_GETHOSTNAME.
> A few don't:  frv, ia64, & xtensa.
> But all arches (except for um) #define __NR_gethostname.
>
> Is __ARCH_WANT_SYS_GETHOSTNAME just crufty and doesn't matter
> any more?

I know you can implement it by simply calling uname.
Beyond that I am puzzled.

Eric
