Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUDMJ0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 05:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUDMJ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 05:26:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:38113 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263304AbUDMJ0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 05:26:40 -0400
Date: Tue, 13 Apr 2004 02:26:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, helgehaf@aitel.hist.no
Subject: Re: 2.6.5-mm5 devpts filesystem doesn't work
Message-Id: <20040413022617.4fb9601e.akpm@osdl.org>
In-Reply-To: <200404131119.05338@WOLK>
References: <20040412221717.782a4b97.akpm@osdl.org>
	<20040413011133.2d15a4d6.akpm@osdl.org>
	<20040413013942.181cb2b5.akpm@osdl.org>
	<200404131119.05338@WOLK>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
>
> On Tuesday 13 April 2004 10:39, Andrew Morton wrote:
> 
> Hi Andrew,
> 
> > yes, that patch is bust.  And rwsem-scale.patch is oopsing all over the
> > place.  Ho hum.
> > I've trashed 2.6.5-mm5 and am uploading 2.6.5-mm5-1, same place.
> 
> where is the announce?

didn't do one.

> Just wondering why at least these:
> 
> - devinet-ctl_table-fix.patch

I don't think this actually fixed anything.

> - ipmi-socket-interface.patch

It doesn't look like we're proceeding with this.
