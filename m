Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRCBOBK>; Fri, 2 Mar 2001 09:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbRCBOBB>; Fri, 2 Mar 2001 09:01:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:61740 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129159AbRCBOAr>; Fri, 2 Mar 2001 09:00:47 -0500
Date: Fri, 2 Mar 2001 15:01:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
Message-ID: <20010302150138.A18366@athlon.random>
In-Reply-To: <97m6ue$7uu$1@penguin.transmeta.com> <8165.983522444@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8165.983522444@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Fri, Mar 02, 2001 at 08:40:44AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 08:40:44AM +0000, David Howells wrote:
> no matter how finely optimised the algorithm... But merging wouldn't be done
> very often... only on memory allocation calls.

Correct, it would happen only at mmap time of course.

> Perhaps it'd be reasonable to only do VMA merging on mmap calls and not brk
> calls, and let brk manually extend an existing VMA if possible.

Yep.

Andrea
