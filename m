Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbWG1Txi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWG1Txi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWG1Txh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:53:37 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:41399 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030301AbWG1Txg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:53:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CckHeMJodgfBTETFQiZVsoH3Gn5ZK75IrbDx14bqCuX8Llk+JDv9ewUpYM2NTC6qWqh0y4xUozKjnYRi1Jn46VG9VLhkQgj2ulHREigX2RxkRf1oCf/t6K83C2JmkmjMJbOKHjGIfvxpVzfhP8MD/fyIXHhhRXmIxkYKWgh7YOA=
Message-ID: <6bffcb0e0607281253j28e04ba2icec85589e9390b3e@mail.gmail.com>
Date: Fri, 28 Jul 2006 21:53:34 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Matt Helsley" <matthltc@us.ibm.com>
Subject: Re: 2.6.18-rc2-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Shailabh Nagar" <nagar@watson.ibm.com>,
       "Balbir Singh" <balbir@in.ibm.com>
In-Reply-To: <1154112567.21787.2522.camel@stark>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com>
	 <6bffcb0e0607280117k68184559t531b737815b2c6e9@mail.gmail.com>
	 <20060728013442.6fabae54.akpm@osdl.org>
	 <1154112567.21787.2522.camel@stark>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/06, Matt Helsley <matthltc@us.ibm.com> wrote:
> On Fri, 2006-07-28 at 01:34 -0700, Andrew Morton wrote:
> > On Fri, 28 Jul 2006 10:17:44 +0200
> > "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> >
> > > Matt, can you look at this?
> > >
> > > My hunt file shows me, that this patches are causing oops.
> > > GOOD
> > > #
> > > #
> > > task-watchers-task-watchers.patch
> > > task-watchers-register-process-events-task-watcher.patch
> > > task-watchers-refactor-process-events.patch
> > > task-watchers-make-process-events-configurable-as.patch
> > > task-watchers-allow-task-watchers-to-block.patch
> > > task-watchers-register-audit-task-watcher.patch
> > > task-watchers-register-per-task-delay-accounting.patch
> > > task-watchers-register-profile-as-a-task-watcher.patch
> > > task-watchers-add-support-for-per-task-watchers.patch
> > > task-watchers-register-semundo-task-watcher.patch
> > > task-watchers-register-per-task-semundo-watcher.patch
> > > BAD
> >
> > Thanks for working that out.
>
>         I noticed the delay accounting functions in the stack trace. Perhaps
> task-watchers-register-per-task-delay-accounting.patch is causing the
> problem.

Confirmed.

>
> Cheers,
>         -Matt Helsley
>
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
