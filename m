Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTH1QPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbTH1QPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:15:14 -0400
Received: from village.ehouse.ru ([193.111.92.18]:62724 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S263290AbTH1QPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:15:10 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-testX and InnoDB (was: Re: 2.6.0-test2-mm3 and mysql)
Date: Thu, 28 Aug 2003 20:15:15 +0400
User-Agent: KMail/1.5
References: <1059871132.2302.33.camel@mars.goatskin.org> <20030804000514.GY22824@waste.org> <200308271952.29331.rathamahata@php4.ru>
In-Reply-To: <200308271952.29331.rathamahata@php4.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308282015.15580.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Wednesday 27 August 2003 19:52, Sergey S. Kostyliov wrote:
> On Monday 04 August 2003 04:05, Matt Mackall wrote:

<cut>

> > All Linux kernels prior to 2.6.0-test2-mm3-1 would silently fail to
> > complete fsync() and msync() operations if they encountered an I/O
> > error, resulting in corruption. If a particular disk subsystem was
> > producing these errors, the symptoms would likely be:
> >
> > - no error reported
> > - no messages in logs
> > - independent of kernel version, etc.
> > - suddenly appear at some point in drive life
> > - works flawlessly on other machines
> >
> > If you can reproduce this corruption, please try running against mm3-1
> > and seeing if it reports problems (both to fsync and in logs).
>
> I've just got another one InnoDB crash with 2.6.0-test4.
> As in previous case there was no messages in kernel log.
> You can find mysql error log here.
> Re: 2.6.0-test2-mm3 and mysql

And here is another one InnoDB crash I've just got with 2.6.0-test4.
http://sysadminday.org.ru/linux-2.6.0-test4_InnoDB_crash-20030828
No messages in kernel log :((

>
> It's a development server, so this isn't a big problem.
> I do understand that this can easily be a hardware problem,
> but the kernel silence is really sad in such case.
> Memory is fine (at least according to memtest 3.0).
>
> Any hints will be appreciated.

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
