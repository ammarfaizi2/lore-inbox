Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264748AbUEOA53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbUEOA53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUEOAyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:54:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:28298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264663AbUEOAuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:50:50 -0400
Date: Fri, 14 May 2004 17:53:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, rene.herman@keyaccess.nl,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-Id: <20040514175313.1bce3447.akpm@osdl.org>
In-Reply-To: <20040514032657.GB704@elf.ucw.cz>
References: <409F4944.4090501@keyaccess.nl>
	<200405102125.51947.bzolnier@elka.pw.edu.pl>
	<409FF068.30902@keyaccess.nl>
	<200405102352.24091.bzolnier@elka.pw.edu.pl>
	<20040510215626.6a5552f2.akpm@osdl.org>
	<20040510221729.3b8e93da.akpm@osdl.org>
	<20040514032657.GB704@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > > It's a bit grubby, but we could easily add a fourth state to
> > >  `system_state': split SYSTEM_SHUTDOWN into SYSTEM_REBOOT and SYSTEM_HALT. 
> > >  That would be a quite simple change.
> > 
> > Like this.  I checked all the SYSTEM_FOO users and none of them seem to
> > care about the shutdown state at present.  Easy.
> 
> Perhaps this should be parameter to device_shutdown? This is quite
> ugly.

That was judged to be a 2.7 exercise.  Seems to affect 143 files already.
