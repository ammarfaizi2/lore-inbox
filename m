Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135718AbRDSVUE>; Thu, 19 Apr 2001 17:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135716AbRDSVTy>; Thu, 19 Apr 2001 17:19:54 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:47248 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135719AbRDSVTn>;
	Thu, 19 Apr 2001 17:19:43 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104191347480.1182-100000@penguin.transmeta.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 19 Apr 2001 14:18:53 -0700
In-Reply-To: Linus Torvalds's message of "Thu, 19 Apr 2001 13:49:05 -0700 (PDT)"
Message-ID: <m3pue8ziyq.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> > I fail to see how this works across processes.
> 
> It's up to FS_create() to create whatever shared mapping is needed.

No, the point is that FS_create is *not* the one creating the shared
mapping.  The user is explicitly doing this her/himself.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
