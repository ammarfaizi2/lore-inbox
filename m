Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWENDOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWENDOt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 23:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWENDOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 23:14:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932358AbWENDOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 23:14:48 -0400
Date: Sat, 13 May 2006 20:11:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jak@isp2dial.com, linux-kernel@vger.kernel.org
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
Message-Id: <20060513201144.4891ef17.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605120949060.3866@g5.osdl.org>
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
	<20060511175143.GH25646@redhat.com>
	<Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr>
	<200605121619.k4CGJCtR004972@isp2dial.com>
	<Pine.LNX.4.58.0605121222070.5579@gandalf.stny.rr.com>
	<200605121630.k4CGUuiU005025@isp2dial.com>
	<Pine.LNX.4.64.0605120949060.3866@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> The cost of keeping a filesystem is not normally very high. The way 
>  filesystems in particular get deprecated is if they have really serious 
>  problems, and nobody ends up being able or willing to fix them at all, and 
>  you _can_ migrate away.

That's the case with smbfs and cifs, soon.

> But if we're talking about win98, it probably 
>  still actually has a pretty big user base, and most of the machines that 
>  run it probably really cannot upgrade.

cifs doesn't support w98 and w95 properly yet.  Steve's working on
it, and we hope to have that in place for 2.6.18.

So at this stage, 2.6.18 still appears to be a good time to start pushing
people toward cifs, and December looks like an appropriate time to mark
smbfs as broken.  Subject to, of course, feedback-from-the-field.

