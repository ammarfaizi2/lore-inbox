Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVAKW5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVAKW5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVAKWyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:54:44 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:3035 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262931AbVAKWvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:51:42 -0500
Message-Id: <200501112251.j0BMp9iZ006964@localhost.localdomain>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Lee Revell <rlrevell@joe-job.com>, Matt Mackall <mpm@selenic.com>,
       Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Tue, 11 Jan 2005 22:41:52 +0100."
             <20050111214152.GA17943@devserv.devel.redhat.com> 
Date: Tue, 11 Jan 2005 17:51:09 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.197.39.54] at Tue, 11 Jan 2005 16:51:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Jan 11, 2005 at 04:38:14PM -0500, Lee Revell wrote:
>> Yes but a bug in an app running as root can trash the filesystem.  The
>> worst you can do with RT privileges is lock up the machine.
>
>several filesystem and IO threads run at prio -10 but not RT.
>That makes me a bit less sure of your statement....

Its completely orthogonal. Lee didn't say "tasks running without RT
can't mess up filesystems". He said "tasks running as root can trash
the filesystem" and "tasks running as RT can lock up the
machine". obviously, the intersection point (a root, RT task) is
double trouble.

--p

