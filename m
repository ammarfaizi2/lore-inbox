Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVCSLdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVCSLdc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 06:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVCSLdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 06:33:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46221 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262446AbVCSLd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 06:33:27 -0500
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       diegocg@gmail.com, lsorense@csclub.uwaterloo.ca, riel@redhat.com,
       nigelenki@comcast.net
Subject: Re: binary drivers and development
References: <1110517070.1949.60.camel@cube>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Mar 2005 04:29:54 -0700
In-Reply-To: <1110517070.1949.60.camel@cube>
Message-ID: <m1br9f27rh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> writes:

> Lennart Sorensen writes:
> 
> > You forgot the very important:
> >    - Only works on architecture it was compiled for.  So anyone not
> >      using i386 (and maybe later x86-64) is simply out of luck.  What do
> >      nvidia users that want accelerated nvidia drivers for X DRI do
> >      right now if they have a powerpc or a sparc or an alpha?  How about
> >      porting Linux to a new architecture.  With binary drivers you now
> >      start out with no drivers on the new architecture except for the
> >      ones you have source for.  Not very productive.
> 
> Rik van Riel writes:
> 
> > No, it wouldn't.  I can use a source code driver on x86,
> > x86-64 and PPC64 systems, but a binary driver is only
> > usable on the architecture it was compiled for.
> >
> > Source code is way more portable than binary anything.
> 
> The kernel already has an AML interpreter for ACPI. **duck**
> 
> As for portability, AML would do the job. It beats typical
> vendor source code IMHO, because endianness and integer size
> are well-defined. (like the Java VM and .net)

Last I looked the kernel implemented opcodes that were not
in the ACPI spec.  So I would go with defined, but not
well defined.

Eric
