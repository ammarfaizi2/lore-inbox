Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbTBQCai>; Sun, 16 Feb 2003 21:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbTBQCai>; Sun, 16 Feb 2003 21:30:38 -0500
Received: from mnh-1-07.mv.com ([207.22.10.39]:59140 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265587AbTBQCah>;
	Sun, 16 Feb 2003 21:30:37 -0500
Message-Id: <200302170234.VAA03818@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Roland McGrath <roland@redhat.com>
cc: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Signal/gdb oddity in 2.5.61 
In-Reply-To: Your message of "Sun, 16 Feb 2003 17:00:36 PST."
             <200302170100.h1H10aQ28610@magilla.sf.frob.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Feb 2003 21:34:23 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

roland@redhat.com said:
> Anyone who wants to use an old gdb with a new kernel can use "handle
> SIGSTOP nopass".  Is that a real imposition?  Anyway, aside from the
> test suite, it only affects gdb users in a way that may confuse them
> for a few seconds but doesn't prevent them from debugging normally. 

It may also affect UML, since it has come to know exactly what to expect
from a ptraced process.  So, when you have the semantics nailed down and
implemented, can you see if UML still runs?

Not that it's a showstopper if it doesn't, but I'd like to know so I can
fiddle UML so that it continues to run.

				Jeff

