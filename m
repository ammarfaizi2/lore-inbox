Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWBKPTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWBKPTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWBKPTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:19:09 -0500
Received: from xenotime.net ([66.160.160.81]:45217 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932313AbWBKPTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:19:08 -0500
Date: Sat, 11 Feb 2006 07:19:48 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, pavel@ucw.cz, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-Id: <20060211071948.4ea2079f.rdunlap@xenotime.net>
In-Reply-To: <m1wtg23tcb.fsf@ebiederm.dsl.xmission.com>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	<200602022131.59928.nigel@suspend2.net>
	<20060202115907.GH1884@elf.ucw.cz>
	<200602022214.52752.nigel@suspend2.net>
	<20060202152316.GC8944@ucw.cz>
	<20060202132708.62881af6.akpm@osdl.org>
	<m1wtg23tcb.fsf@ebiederm.dsl.xmission.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2006 06:42:12 -0700 Eric W. Biederman wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > - If you want my cheerfully uninformed opinion, we should toss both of
> >   them out and implement suspend3, which is based on the kexec/kdump
> >   infrastructnure.  There's so much duplication of intent here that it's not
> >   funny.  And having them separate like this weakens both in the area where
> >   the real problems are: drivers.
> 
> Ahh!!! I'm surrounded.
> 
> suspend by kexec
> suspend by migration
> 
> Is there a way out?
> 
> Can I avoid it?
> 
> Do all roads lead to suspend?
> 
> :)

All is not lost.
Recently I've had good results with suspend-to-disk (sort of a who cares).
And suspend-to-RAM seems to work for me.... but no resume. :(

---
~Randy
