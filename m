Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWEQRfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWEQRfI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWEQRfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:35:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44692 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750757AbWEQRfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:35:06 -0400
Date: Wed, 17 May 2006 19:06:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Over-heating CPU on 2.6.16 with Thinkpad G41
Message-ID: <20060517170601.GA9459@elf.ucw.cz>
References: <Pine.LNX.4.58.0605160253010.4283@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0605160253010.4283@gandalf.stny.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 16-05-06 03:05:06, Steven Rostedt wrote:
> 
> Last night compiling kernels in my hotel, my CPUs kept over-heating.
> 
> I have a IBM Thinkpad G41 which has a pentium 4 HT.
> 
> Before compiling, my CPU temp would start at 65C and go up to 82 before I
> kill the compile. At 80 it warns me.  I rebooted a few times, but it would
> always happen.  Thinking this might be bad hardware, I rebooted into
> 2.6.12, and saw that the CPU temperature would be at 52C??  I had no more
> problems compiling.

Temperatures up-to 95C are okay on many machines.

> I recently added the Suspend2 patch and that might be the culprit, But I
> just booted, a version of 2.6.16 that doesn't have the patch, and it too
> seems to be runnig hot.

Ask nigel if you suspenct that patch. But from your description it
screams "random overheating".

> Hmm, could this be the "acpi_sleep=s3_bios" that Suspend2 asks for?
> I haven't removed that option yet.

This option has 0 effect until you suspend to RAM.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
