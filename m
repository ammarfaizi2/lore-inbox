Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271858AbRIIDGx>; Sat, 8 Sep 2001 23:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271860AbRIIDGm>; Sat, 8 Sep 2001 23:06:42 -0400
Received: from mnh-1-11.mv.com ([207.22.10.43]:63493 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S271858AbRIIDGg>;
	Sat, 8 Sep 2001 23:06:36 -0400
Message-Id: <200109090423.XAA03403@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: expand_stack fix [was Re: 2.4.9aa3] 
In-Reply-To: Your message of "Sat, 08 Sep 2001 18:04:16 +0200."
             <20010908180416.Z11329@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Sep 2001 23:23:38 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrea@suse.de said:
> My fix for the race doesn't drop the usability of GROWSDOWN that could
> otherwise break userspace programs. I guess at least uml uses
> growsdown vma file backed. Jeff? 

No.  In neither the host kernel or UML is there a vma that's file backed and
growsdown.

UML process stacks are marked growsdown in UML and are file backed on the host,
but that's not the same thing.

				Jeff

