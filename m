Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135786AbRDTCrD>; Thu, 19 Apr 2001 22:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135785AbRDTCqq>; Thu, 19 Apr 2001 22:46:46 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:38552 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135784AbRDTCqh>;
	Thu, 19 Apr 2001 22:46:37 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.GSO.4.21.0104192044300.19860-100000@weyl.math.psu.edu>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 19 Apr 2001 19:45:02 -0700
In-Reply-To: Alexander Viro's message of "Thu, 19 Apr 2001 21:35:02 -0400 (EDT)"
Message-ID: <m33db4xpap.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> > If the new interface can be useful for anything it must allow to
> > implement process-shared POSIX mutexes.
> 
> Pardon me the bluntness, but... Why?

Because otherwise there is no reason to even waste a second with this.
At least for me and everybody else who has interest in portable solutions.

I don't care how it's implemented.  Look at the code example I posted.
If you can provide an implementation which can implement anonymous
inter-process mutexes then ring again.  Until then I'll wait.  If you
implement something else I couldn't care less since it's useless for
me.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
