Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277898AbRJISqJ>; Tue, 9 Oct 2001 14:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277899AbRJISqB>; Tue, 9 Oct 2001 14:46:01 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:36302 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S277898AbRJISpq>; Tue, 9 Oct 2001 14:45:46 -0400
Date: Tue, 9 Oct 2001 14:46:19 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110091846.f99IkJL10274@devserv.devel.redhat.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: is reparent_to_init a good thing to do?
In-Reply-To: <mailman.1002644159.30689.linux-kernel2news@redhat.com>
In-Reply-To: <3BC3118B.8050001@wipro.com> <mailman.1002644159.30689.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right now, it's probably the case that nfsd threads will turn
> into zombies when they terminate, *if* their parent is still
> running.   But of course, most kernel threads are parented
> by very short-lived userspace applications, so nobody has
> ever noticed.

Oh, this is how khubd zombies get about. Now I see...

-- Pete
