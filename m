Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUCAKIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbUCAKIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:08:11 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:47878 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S261171AbUCAKIF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:08:05 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropping CONFIG_PM_DISK?
References: <1ulUA-33w-3@gated-at.bofh.it>
	<20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>
	<yw1x4qt93i6y.fsf@kth.se> <20040229181053.GD286@elf.ucw.cz>
	<yw1xznb120zn.fsf@kth.se> <20040301094023.GF352@elf.ucw.cz>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 01 Mar 2004 11:08:01 +0100
In-Reply-To: <20040301094023.GF352@elf.ucw.cz> (Pavel Machek's message of
 "Mon, 1 Mar 2004 10:40:23 +0100")
Message-ID: <yw1xhdx8ani6.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> > Try current swsusp with minimal drivers, init=/bin/bash.
>> 
>> Well, if I do that it works.  Or at least some old version did, I
>> assume the later ones would too.  However, that sort of removes the
>> whole point.  Taking down the system enough to be able to unload
>> almost everything is as close as rebooting you'll get.
>
> Well, now do a search for "which module/application causes failure".

I know, it just takes an awful time.

>> BTW, is there some easier way to track the development than using the
>> patches from the web page?  Unpatching after a couple of BK merges
>> isn't the easiest thing.  Is there a BK tree somewhere I can pull
>> from?
>
> Are you using swsusp2?

Well, trying to.  Isn't it supposed to be the latest and greatest?

> That's _not_ what I'm talking about. swsusp is in mainline.

It would still be the same module(s) that caused it to fail, right?

-- 
Måns Rullgård
mru@kth.se
