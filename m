Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSLVUmd>; Sun, 22 Dec 2002 15:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSLVUmd>; Sun, 22 Dec 2002 15:42:33 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:22276 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S265285AbSLVUmc>;
	Sun, 22 Dec 2002 15:42:32 -0500
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212221132370.2692-100000@home.transmeta.com>
	<3E0617A9.90405@redhat.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <3E0617A9.90405@redhat.com>
Date: 22 Dec 2002 15:50:32 -0500
Message-ID: <m3adixvkvb.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ulrich" == Ulrich Drepper <drepper@redhat.com> writes:

Ulrich> I've talked to our guy producing the glibc RPMs and he said
Ulrich> that he'll produce them soon.  We'll let people know when it
Ulrich> happened.

I'd tend to prefer an LD_PRELOAD-able dso that just set up %gs and had
entries for each of the foo(2) over a full glibc rpm.  I've only got
the one box to test on right now, but would like to see how well
sysenter¹ works.

-JimC

¹ Assuming I didn't just mix up the intel and amd opcodes....

