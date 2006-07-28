Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161314AbWG1VfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161314AbWG1VfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161315AbWG1VfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:35:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161314AbWG1VfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:35:10 -0400
Date: Fri, 28 Jul 2006 14:34:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com
Subject: Re: 2.6.18-rc2-mm1
Message-Id: <20060728143454.8ca04c4c.akpm@osdl.org>
In-Reply-To: <1154119190.21787.2528.camel@stark>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com>
	<6bffcb0e0607280117k68184559t531b737815b2c6e9@mail.gmail.com>
	<20060728013442.6fabae54.akpm@osdl.org>
	<1154112567.21787.2522.camel@stark>
	<6bffcb0e0607281253j28e04ba2icec85589e9390b3e@mail.gmail.com>
	<1154119190.21787.2528.camel@stark>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 13:39:50 -0700
Matt Helsley <matthltc@us.ibm.com> wrote:

> > >         I noticed the delay accounting functions in the stack trace. Perhaps
> > > task-watchers-register-per-task-delay-accounting.patch is causing the
> > > problem.
> > 
> > Confirmed.
> 
> Excellent, thanks for the rapid confirmation. I'll work with Shailabh
> and Balbir to fix this. In the meantime perhaps
> task-watchers-register-per-task-delay-accounting.patch should be dropped
> from -mm.

I think the whole patch series should be dropped, sorry.  We will
occasionally add more runtime overhead to gain code maintainability or
readability or to squach warnings.  But I do think this patchset goes too
far.
