Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbRAGJTj>; Sun, 7 Jan 2001 04:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRAGJT3>; Sun, 7 Jan 2001 04:19:29 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:43752 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S129631AbRAGJTP>; Sun, 7 Jan 2001 04:19:15 -0500
Date: Sun, 7 Jan 2001 10:19:42 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: Ulrich Drepper <drepper@cygnus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] new bug report script
In-Reply-To: <m3vgrrafzs.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.4.30.0101071011500.7104-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2001, Ulrich Drepper wrote:

> have libc5 out of the way in a separate subdir.  Your best bet is to
> use ldconfig:
>
>   /sbin/ldconfig -p|grep libc.so.5
>

Hmm, ok. Well, I was reading the Changes document when doing this first
and did not use my head. This document advises to deduct the version
number from 'ls -l /lib/libc*'.

I will fix this so that ldconfig is used for the libraries. That
would be the best.

BTW, can you tell me what the console-tools are? They are checked in the
ver_linux script but I have never heard of them. Are they a replacement
for kbd?

Furthermore, is the name of RedHat's gcc for the kernel always 'kgcc'?

TIA,
 Matthias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
