Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUCAKpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUCAKpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:45:32 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:55969 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261197AbUCAKpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:45:25 -0500
Date: Mon, 01 Mar 2004 18:45:04 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Dropping CONFIG_PM_DISK?
Cc: linux-kernel@vger.kernel.org
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <20040229181053.GD286@elf.ucw.cz> <yw1xznb120zn.fsf@kth.se> <20040301094023.GF352@elf.ucw.cz> <yw1xhdx8ani6.fsf@kth.se>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr36itevo4evsfm@smtp.pacific.net.th>
In-Reply-To: <yw1xhdx8ani6.fsf@kth.se>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2004 11:08:01 +0100, Måns Rullgård <mru@kth.se> wrote:

> Pavel Machek <pavel@ucw.cz> writes:
>
>>> > Try current swsusp with minimal drivers, init=/bin/bash.
>>>
>>> Well, if I do that it works.  Or at least some old version did, I
>>> assume the later ones would too.  However, that sort of removes the
>>> whole point.  Taking down the system enough to be able to unload
>>> almost everything is as close as rebooting you'll get.
>>
>> Well, now do a search for "which module/application causes failure".
>
> I know, it just takes an awful time.
>
>>> BTW, is there some easier way to track the development than using the
>>> patches from the web page?  Unpatching after a couple of BK merges
>>> isn't the easiest thing.  Is there a BK tree somewhere I can pull
>>> from?
>>
>> Are you using swsusp2?
>
> Well, trying to.  Isn't it supposed to be the latest and greatest?
>
>> That's _not_ what I'm talking about. swsusp is in mainline.
>
> It would still be the same module(s) that caused it to fail, right?
>

Further to my post yesterday, here is a short article which may be of interest.

http://lwn.net/Articles/68747/

So, to make it work better lets get PM usable :)

swsusp2 mailing list: swsusp-devel@lists.sourceforge.net

Regards
Michael
