Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVDWISv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVDWISv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 04:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVDWISu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 04:18:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:26571 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261433AbVDWISt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 04:18:49 -0400
Message-ID: <426A04E3.2040703@suse.de>
Date: Sat, 23 Apr 2005 10:18:43 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Pavel Machek <pavel@ucw.cz>, rjw@sisk.pl,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Steinmetz <ast@domdv.de>
Subject: Re: Linux 2.6.12-rc3: various swsusp problems
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>	 <4267DC2E.9030102@domdv.de> <20050421185717.GB475@openzaurus.ucw.cz>	 <42691498.7060003@suse.de> <d120d500050422195755c5b918@mail.gmail.com>
In-Reply-To: <d120d500050422195755c5b918@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 4/22/05, Stefan Seyfried <seife@suse.de> wrote:

>> -               printk(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
>> +               printk(KERN_ERR "swsusp: Suspend partition is no suspend image.\n");
> 
> Hrm, I don't think it is a good message... What about "Suspend
> partition has no suspend image" or, better yet, "Suspend partition

fine with me,

> does not contain valid suspend image"?

the shorter, the better IMO but i do not really care to be honest.
It should just express that this usually is no error, so "wrong
signature" and maybe "not valid image" may scare the users. "has no
suspend image" sounds 'mostly harmless', so it may be best.

All IMO, and i am no native english speaker, so some proofreading is
always a good idea :-)
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
