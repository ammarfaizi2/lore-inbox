Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbUB2SK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 13:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUB2SK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 13:10:28 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:50357 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262091AbUB2SK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 13:10:26 -0500
Date: Mon, 01 Mar 2004 02:10:09 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Dropping CONFIG_PM_DISK?
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se>
Cc: "Software suspend" <swsusp-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr348q7yi4evsfm@smtp.pacific.net.th>
In-Reply-To: <yw1x4qt93i6y.fsf@kth.se>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004 18:32:21 +0100, Måns Rullgård <mru@kth.se> wrote:

> Pavel Machek <pavel@ucw.cz> writes:
>
>> Hi!
>>
>>> > Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
>>> > It seems noone is maintaining it, equivalent functionality is provided
>>> > by swsusp, and it is confusing users...
>>>
>>> It may be ugly, it may be unmaintained, but I get the impression that it
>>> works for some people for whom swsusp doesn't. So unless swsusp works for
>>> everyone or Nigel's swsusp2 is merged, I'd suggest leaving that in.
>>
>> Do you have example when pmdisk works and swsusp does not? I'm not
>> aware of any in recent history...
>
> For me, none of them (pmdisk, swsusp and swsusp2) work.  I did manage
> to get pmdisk to resume once, and swsusp2 makes it half-way through
> the resume.

Hate to hear this - 2.0 is said to work _flawlessly_ on 2.4.24 and
on 2.6.2 within the bounds of more complex PM/driver issues.

2.4.25 and 2.6.3 patches are undergoing testing.

If you like to try again, please have a look at http://swsusp.sf.net.

There is also comprehensive FAQ and Howto on the site.

You also will find a lot of user support wrt specific HW.

Myself is running 2.0 on 2.4.2[345] without any stability issues
whatsoever this year.

In short, I am confident we can make it work for you!

Regards
Michael
