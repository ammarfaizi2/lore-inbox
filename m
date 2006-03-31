Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWCaQlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWCaQlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWCaQlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:41:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38850 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751084AbWCaQli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:41:38 -0500
To: sds@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Chris Wright <chrisw@sous-sol.org>,
       Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
References: <20060328142639.GE14576@MAIL.13thfloor.at>
	<44294BE4.2030409@yahoo.com.au>
	<m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net>
	<20060329182027.GB14724@sorel.sous-sol.org>
	<442B0BFE.9080709@vilain.net>
	<20060329225241.GO15997@sorel.sous-sol.org>
	<m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
	<20060330013618.GS15997@sorel.sous-sol.org>
	<m164lwfy1c.fsf@ebiederm.dsl.xmission.com>
	<20060330192308.GZ15997@sorel.sous-sol.org>
	<m1hd5fb1bz.fsf@ebiederm.dsl.xmission.com>
	<1143816746.24555.317.camel@moss-spartans.epoch.ncsc.mil>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 31 Mar 2006 09:39:22 -0700
In-Reply-To: <1143816746.24555.317.camel@moss-spartans.epoch.ncsc.mil> (Stephen
 Smalley's message of "Fri, 31 Mar 2006 09:52:26 -0500")
Message-ID: <m1irpua7r9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> writes:

> On Thu, 2006-03-30 at 23:00 -0700, Eric W. Biederman wrote:
>> I do still need to read up on the selinux mandatory access controls.
>> Although the comment from the NSA selinux FAQ about selinux being
>> just a proof-of-concept and no security bugs were discovered or
>> looked for during it's implementation scares me.  
>
> Point of clarification:  The original SELinux prototype NSA released in
> Dec 2000 based on Linux 2.2.x kernels was a proof-of-concept reference
> implementation.  I wouldn't describe the current implementation in
> mainline Linux 2.6 and certain distributions in the same manner.  Also,
> the separate Q&A about "did you try to fix any vulnerabilities" is just
> saying that NSA did not perform a thorough code audit of the entire
> Linux kernel; we just implemented the extensions needed for mandatory
> access control.
>
> http://selinux.sf.net/resources.php3 has some good pointers for SELinux
> resources.  There is also a recently created SELinux news site at
> http://selinuxnews.org/wp/.

Thanks.  I am concerned that there hasn't been an audit, of at least
the core kernel.

My first interaction with security modules was that I fixed a but
where /proc/pid/fd was performing the wrong super user security
checks and the system became unusable for people using selinux.

Eric
