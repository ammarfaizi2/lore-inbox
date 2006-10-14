Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWJNR4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWJNR4e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWJNR4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 13:56:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38195 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422726AbWJNR4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 13:56:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sjCkNkCGIkO1n/QGBdQG+I7/Lzwt5OzQHi5sqia00SO0wohQa8X3pa9ObhFGdia1vUZnr9Qx1zlFVO0z9XpBQcW1ZEVrXZ93ILX9si3FKVoXCopZCdXU4Z1mPguIxCigZ+G0mi1qKRfQYCbR65hT2Km2z62FBQ7evg/Ve1Tokbs=
Message-ID: <6bffcb0e0610141056t44365ab2p3972d0a95dba33da@mail.gmail.com>
Date: Sat, 14 Oct 2006 19:56:31 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: BUG: warning at fs/inotify.c:181 with linux-2.6.18
Cc: syphir@syphir.sytes.net, linux-kernel@vger.kernel.org
In-Reply-To: <4525B546.7070305@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <452581D7.5020907@syphir.sytes.net> <4525B546.7070305@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> C.Y.M wrote:
> > Since I updated to 2.6.18, I have had the following warnings in my syslog.  Is
> > this a known problem? Better yet, is there a solution to this?  I am running on
> > a i686 (Athlon XP) 32 bit cpu compiled under gcc-3.4.6.
> >
> >
> > Oct  5 08:27:31 sid kernel: BUG: warning at
> > fs/inotify.c:181/set_dentry_child_flags()
> > Oct  5 08:27:31 sid kernel:  [<c0182a10>] set_dentry_child_flags+0x170/0x190
> > Oct  5 08:27:31 sid kernel:  [<c0182adf>] remove_watch_no_event+0x5f/0x70
> > Oct  5 08:27:31 sid kernel:  [<c0182b08>] inotify_remove_watch_locked+0x18/0x50
> > Oct  5 08:27:31 sid kernel:  [<c01833dc>] inotify_rm_wd+0x6c/0xb0
> > Oct  5 08:27:31 sid kernel:  [<c0183e98>] sys_inotify_rm_watch+0x38/0x60
> > Oct  5 08:27:31 sid kernel:  [<c0102d8f>] syscall_call+0x7/0xb
>
> I don't think it is a known problem. Is it reproduceable?

It is a known problem.
http://www.ussg.iu.edu/hypermail/linux/kernel/0608.1/1209.html

> Any idea what
> is making the inotify syscalls?
>
> --
> SUSE Labs, Novell Inc.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
