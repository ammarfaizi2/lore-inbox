Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269969AbRHQHrc>; Fri, 17 Aug 2001 03:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269897AbRHQHrX>; Fri, 17 Aug 2001 03:47:23 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:15863 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269804AbRHQHrE>;
	Fri, 17 Aug 2001 03:47:04 -0400
Subject: Re: ext2 not NULLing deleted files?
From: Robert Love <rml@tech9.net>
To: Enver Haase <ehaase@inf.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01081709381000.08800@haneman>
In-Reply-To: <01081709381000.08800@haneman>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 17 Aug 2001 03:47:43 -0400
Message-Id: <998034466.663.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001 09:38:10 +0200, Enver Haase wrote:
> I just recognized there's an "undelete" now for ext2 file systems [a KDE 
> app].
> 
> "The Other OS" in its professional version does of course clear the deleted 
> blocks with 0's for security reasons; I would have bet a thousand bucks Linux 
> would do so, too [seems I should have read the source code, good thing no-one 
> wanted to take on the bet :) ].

By "The Other OS" I assume you mean NT.  NT does _not_ zero files on
delete, either with NTFS or anything else.  It merely unlinks them like
any other OS.  I can't think of anything that nullifies files, except
utilities meant solely to do that (often called "sweeping").

Do you have any idea how long it would take to zero files?  If you
removed even a moderately sized directory, it would take a _very long_
time.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

