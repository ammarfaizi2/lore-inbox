Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267642AbUG3Mlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267642AbUG3Mlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 08:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267674AbUG3Mlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 08:41:36 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:30924 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267669AbUG3Mlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 08:41:32 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       suparna@in.ibm.com, fastboot@osdl.org, mbligh@aracnet.com,
       jbarnes@engr.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API 
In-reply-to: Your message of 29 Jul 2004 18:04:06 MDT.
             <m1zn5i2weh.fsf@ebiederm.dsl.xmission.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8229.1091191092.1@us.ibm.com>
Date: Fri, 30 Jul 2004 05:38:13 -0700
Message-Id: <E1BqWeM-00028t-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 2004 18:04:06 MDT, Eric W. Biederman wrote:
> Gerrit Huizenga <gh@us.ibm.com> writes:
> > 
> > Okay, I may be confused a bit but I *thought* kexec was going to
> > load the thin, new kernel (e.g. read from disk operations, which is
> > better than write to disk operations from the sick kernel).
> 
> /sbin/kexec will load it with sys_kexec_load, before the kernel becomes
> sick.
>  

...

> > That sounds simpler than changing the kernel load process around,
> > ensuring you have the new kexec'd kernel build and loaded, etc.
> > At least it sounds simpler and more in line with using kexec for
> > fastboot as well.
> 
> The only process that is going to be changed around is where
> we store the kernel before we transfer control to it, and when/and
> how that transfer of control happens.

This is what I had missed - the seperation of load and exec.

Thanks, Eric!

gerrit
