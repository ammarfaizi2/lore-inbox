Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131469AbQKCTmL>; Fri, 3 Nov 2000 14:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131545AbQKCTmC>; Fri, 3 Nov 2000 14:42:02 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:41433 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S131469AbQKCTly>;
	Fri, 3 Nov 2000 14:41:54 -0500
To: george@moberg.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a user-land  programmer...
In-Reply-To: <3A03120A.DFC62AD5@moberg.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 03 Nov 2000 11:41:42 -0800
In-Reply-To: george@moberg.com's message of "Fri, 03 Nov 2000 14:29:14 -0500"
Message-ID: <m3y9z0g7wp.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george@moberg.com writes:

> Can we _PLEASE_PLEASE_PLEASE_ not do this anymore and have the kernel do
> what BSD does:  re-start the interrupted call?

This is crap.  Returning EINTR is necessary for many applications.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
