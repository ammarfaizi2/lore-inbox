Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVKVRqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVKVRqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVKVRqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:46:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965039AbVKVRqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:46:51 -0500
Date: Tue, 22 Nov 2005 18:46:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bj?rn Mork <bmork@dod.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051122174643.GB1752@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com> <20051119234850.GC1952@spitz.ucw.cz> <200511220026.55589.dtor_core@ameritech.net> <871x19giuw.fsf@obelix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871x19giuw.fsf@obelix.mork.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[Please Cc me if you want fast reply.]

> > Swsusp: do not time-out when stopping tasks while resuming
> >
> > When stopping tasks during esume process there is no point of
> > eastablishing a timeout because teh process is past the point
> > of no return; there is no possible recovery from failure. If
> > stopping tasks fails resume is aborted and user is forced to
> > do fsck anyway.
> 
> If a clueless users voice counts for anything: I couldn't agree more.  
> 
> A failed resume is a near catastrophy if you use and trust swsusp. And
> how could it ever be useful if you don't?

Failed resume is only as bad as powerfail.

> Maybe that even would give me a chance to fix some hardware problem
> causing the timeout, and then retry the resume.

..while doing resume few times, trying to change hw config to make it
resume is _way_ more dangerous.
								Pavel
-- 
Thanks, Sharp!
