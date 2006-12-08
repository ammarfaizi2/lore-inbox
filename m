Return-Path: <linux-kernel-owner+w=401wt.eu-S1761205AbWLHVCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761205AbWLHVCP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761206AbWLHVCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:02:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36550 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761199AbWLHVCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:02:14 -0500
Date: Fri, 8 Dec 2006 12:58:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>,
       Kylene Hall <kjhall@us.ibm.com>, Dave Safford <safford@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061208125851.842562f5.akpm@osdl.org>
In-Reply-To: <1165586974.12263.190.camel@moss-spartans.epoch.ncsc.mil>
References: <20061204204024.2401148d.akpm@osdl.org>
	<1165586974.12263.190.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 09:09:34 -0500
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Mon, 2006-12-04 at 20:40 -0800, Andrew Morton wrote:
> > mprotect-patch-for-use-by-slim.patch
> > integrity-service-api-and-dummy-provider.patch
> > integrity-service-api-and-dummy-provider-cleanup-use-of-configh.patch
> > integrity-service-api-and-dummy-provider-compilation-warning-fix.patch
> > slim-main-patch.patch
> > slim-main-patch-socket_post_create-hook-return-code.patch
> > slim-main-patch-misc-cleanups-requested-at-inclusion-time.patch
> > slim-main-patch-handle-failure-to-register.patch
> > slim-main-patch-fix-bug-with-mm_users-usage.patch
> > slim-main-patch-security-slim-slm_mainc-make-2-functions-static.patch
> > slim-secfs-patch.patch
> > slim-secfs-patch-slim-correct-use-of-snprintf.patch
> > slim-secfs-patch-cleanup-use-of-configh.patch
> > slim-make-and-config-stuff.patch
> > slim-make-and-config-stuff-makefile-fix.patch
> > slim-debug-output.patch
> > slim-fix-security-issue-with-the-task_post_setuid-hook.patch
> > slim-secfs-inode-i_private-build-fix.patch
> > slim-documentation.patch
> > fdtable-make-fdarray-and-fdsets-equal-in-size-slim.patch
> > 
> >  Shall hold in -mm.
> 
> Why?

They're on hold awaiting further development and awaiting a merge/no-merge
decision.

They're not causing me any trouble.

>  I haven't seen any evidence that prior review comments have been
> addressed so far, and a fresh patch set would be beneficial anyway to
> facilitate full review of the updated code and to allow them to fix
> their patch descriptions as well (as they were wrong in some instances,
> describing older versions of the code).

If/when the developers start doing more work, we can then decide whether
to use incremental patches or to take a drop-them-and-start-again approach.

(If a whole new patch series comes out, I have tricks which allow me to
check that none of the above fixup patches got lost.  Those tricks don't
work if I drop all the patches first)

But yes, it has been pretty quiet.  If there's no intention to proceed with
these patches, someone please tell me.
