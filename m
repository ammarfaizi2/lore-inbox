Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbSI1DBm>; Fri, 27 Sep 2002 23:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262652AbSI1DBm>; Fri, 27 Sep 2002 23:01:42 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:55305
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262650AbSI1DBl>; Fri, 27 Sep 2002 23:01:41 -0400
Subject: Re: Sleeping function called from illegal context...
From: Robert Love <rml@tech9.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10209271835280.13669-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10209271835280.13669-100000@master.linux-ide.org>
Content-Type: text/plain
Organization: 
Message-Id: <1033182396.22584.22.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 27 Sep 2002 23:06:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 22:04, Andre Hedrick wrote:

> See in trying to move to a spinlock it goes totally south.
> So now that you know the where, and why ... please go fix.
> See I am off working with AC on the issues for 2.4.
> 
> Also with PREMPT, bah never mind.

Sigh... I do not want to start this but this problem has nothing to do
with preemption and everything to do with you sleeping while holding a
lock.  It exists whether preempt is on or off.

	Robert Love

