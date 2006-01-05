Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751927AbWAEEoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbWAEEoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 23:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWAEEoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 23:44:39 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29624 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751927AbWAEEoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 23:44:38 -0500
Subject: Re: sched.c:659 dec_rt_tasks BUG with patch-2.6.15-rt1
	(realtime-preempt)
From: Steven Rostedt <rostedt@goodmis.org>
To: Nedko Arnaudov <nedko@arnaudov.name>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87u0cj5riq.fsf_-_@arnaudov.name>
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
	 <20060102214516.GA12850@elte.hu> <87lkxyrzby.fsf_-_@arnaudov.name>
	 <87u0cj5riq.fsf_-_@arnaudov.name>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 23:44:33 -0500
Message-Id: <1136436273.12468.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 04:37 +0200, Nedko Arnaudov wrote:
> > cdrecord issue is still there however. I got new screenshot (attached)
> > for it. In the new one, some stack was dumped before freeze.
> 
> I was able to reproduce this by running oss2jack with -d option too.
> oss2jack -d option daemonizes it. If I run oss2jack without daemonizing,
> everything works and i'm not getting BUG at all.

Could you send me your .config.  And this is a smp machine right?

Thanks,

-- Steve


