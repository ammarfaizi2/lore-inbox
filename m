Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281833AbRKRA1y>; Sat, 17 Nov 2001 19:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281834AbRKRA1o>; Sat, 17 Nov 2001 19:27:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19553 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281833AbRKRA1g>; Sat, 17 Nov 2001 19:27:36 -0500
To: Rock Gordon <rockgordon@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Executing binaries on new filesystem
In-Reply-To: <20011117221821.66121.qmail@web14809.mail.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2001 17:08:47 -0700
In-Reply-To: <20011117221821.66121.qmail@web14809.mail.yahoo.com>
Message-ID: <m1n11l7xf4.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Gordon <rockgordon@yahoo.com> writes:

> Hi,
> 
> I've written a modest filesystem for fun, it works
> pretty ok, but when I try to execute binaries from it,
> bash says "cannot execute binary file" ... If I copy
> the same binary elsewhere, it executes perfectly.
> 
> Does anybody have any clue ?

A classic problem is that the filesystem doesn't support
mmap.  But with more recent kernels I think it would but
hard not too...

Eric
