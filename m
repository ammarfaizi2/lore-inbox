Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUCAJER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUCAJER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:04:17 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:26886 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S261225AbUCAJEJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:04:09 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropping CONFIG_PM_DISK?
References: <1ulUA-33w-3@gated-at.bofh.it>
	<20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>
	<yw1x4qt93i6y.fsf@kth.se> <20040229181053.GD286@elf.ucw.cz>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Sun, 29 Feb 2004 19:29:16 +0100
In-Reply-To: <20040229181053.GD286@elf.ucw.cz> (Pavel Machek's message of
 "Sun, 29 Feb 2004 19:10:53 +0100")
Message-ID: <yw1xznb120zn.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> >> > Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
>> >> > It seems noone is maintaining it, equivalent functionality is provided
>> >> > by swsusp, and it is confusing users...
>> >> 
>> >> It may be ugly, it may be unmaintained, but I get the impression that it
>> >> works for some people for whom swsusp doesn't. So unless swsusp works for
>> >> everyone or Nigel's swsusp2 is merged, I'd suggest leaving that in.
>> >
>> > Do you have example when pmdisk works and swsusp does not? I'm not
>> > aware of any in recent history...
>> 
>> For me, none of them (pmdisk, swsusp and swsusp2) work.  I did manage
>> to get pmdisk to resume once, and swsusp2 makes it half-way through
>> the resume.  The old swsusp doesn't even get that far.
>
> Try current swsusp with minimal drivers, init=/bin/bash.

Well, if I do that it works.  Or at least some old version did, I
assume the later ones would too.  However, that sort of removes the
whole point.  Taking down the system enough to be able to unload
almost everything is as close as rebooting you'll get.

BTW, is there some easier way to track the development than using the
patches from the web page?  Unpatching after a couple of BK merges
isn't the easiest thing.  Is there a BK tree somewhere I can pull
from?

-- 
Måns Rullgård
mru@kth.se
