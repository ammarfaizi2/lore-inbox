Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTEGVPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264232AbTEGVPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:15:08 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:62196 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264231AbTEGVPG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:15:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: petter wahlman <petter@bluezone.no>, root@chaos.analogic.com
Subject: Re: The disappearing sys_call_table export.
Date: Wed, 7 May 2003 16:27:16 -0500
X-Mailer: KMail [version 1.2]
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <1052321673.3727.737.camel@badeip> <Pine.LNX.4.53.0305071247360.12878@chaos> <1052330844.3739.840.camel@badeip>
In-Reply-To: <1052330844.3739.840.camel@badeip>
MIME-Version: 1.0
Message-Id: <03050716271600.07468@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 13:07, petter wahlman wrote:
> On Wed, 2003-05-07 at 18:59, Richard B. Johnson wrote:
>
[snip]
> > The same way you would force a virus to not be statically linked.
> > You make sure that only programs that interface with the kernel
> > thorugh your hooks can run on that particular system.
>
> Can you please elaborate.
> How would you implement the access control without modifying the
> respective syscalls or the system_call(), and would you'r
> solution be possible to implement run time?

Access control is available via the LSM, with well defined interfaces.
If that is what you want to control, then use the LSM, and not the syscall
table.
