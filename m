Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVDXK5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVDXK5h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 06:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVDXK5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 06:57:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51654 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262309AbVDXK5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 06:57:35 -0400
Message-ID: <426B7B97.4030009@suse.de>
Date: Sun, 24 Apr 2005 12:57:27 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: misc cleanups [4/4]
References: <200504232320.54477.rjw@sisk.pl> <200504232338.43297.rjw@sisk.pl> <20050423220757.GD1884@elf.ucw.cz>
In-Reply-To: <20050423220757.GD1884@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> The following patch makes some comments and printk()s in swsusp.c up to date.
>> In particular it adds the string "swsusp" before every message that is printed by
>> the code in swsusp.c.
> 
> I don't like this one. Adding swsusp everywhere just clutters the
> screen, most of it should be clear from context.

I like it. The messages are short enough so we should not get line wraps
and it makes stuff more clear. You know, the context is not familiar to
everyone, just imagine the "why do we {suspend,resume} devices during
{resume,suspend} questions.

Also, i can ask for "send me output of dmesg|grep ^swsusp" to avoid
newbies flooding me with totally irrelevant info ;-)
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
