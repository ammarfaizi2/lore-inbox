Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293084AbSCEAwz>; Mon, 4 Mar 2002 19:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293092AbSCEAwp>; Mon, 4 Mar 2002 19:52:45 -0500
Received: from zero.tech9.net ([209.61.188.187]:57106 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293084AbSCEAwc>;
	Mon, 4 Mar 2002 19:52:32 -0500
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020305004130.GK353@matchmail.com>
In-Reply-To: <1015287791.882.25.camel@phantasy> 
	<20020305004130.GK353@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 19:52:39 -0500
Message-Id: <1015289559.865.43.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 19:41, Mike Fedyk wrote:

> > Users of 2.4+O(1)+preempt (i.e. -ac) should use this patch:
>
> I believe you want to say that O(1)sched is in -ac, and this patch will add
> preempt on top of that, not that preempt is already in -ac (unless I missed
> something...)

Uh, right.  2.4 users who use O(1) (which is in -ac) and preempt-kernel
need to use the aforementioned patch. :)

	Robert Love

