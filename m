Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271046AbRHOFtD>; Wed, 15 Aug 2001 01:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271047AbRHOFsx>; Wed, 15 Aug 2001 01:48:53 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:51899 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S271046AbRHOFsg>;
	Wed, 15 Aug 2001 01:48:36 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mag@fbab.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <200108150532.f7F5WGq01653@penguin.transmeta.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 14 Aug 2001 22:42:11 -0700
In-Reply-To: Linus Torvalds's message of "Tue, 14 Aug 2001 22:32:16 -0700"
Message-ID: <m3snetq3po.fsf@otr.mynet>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> However, part of the problem is that because the limits haven't
> historically existed, there is also no accepted and nice way of
> setting the limits.

This should be the least of the problems.  Simply add new RLIMIT_*
values[1] (and possibly [gs]etrlimit64 syscalls).  The shell's ulimit
command can easily pick those up.  Non-standard, but every other
solution will be, too.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
