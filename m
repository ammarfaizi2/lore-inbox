Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270048AbRHGD1v>; Mon, 6 Aug 2001 23:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270050AbRHGD1l>; Mon, 6 Aug 2001 23:27:41 -0400
Received: from smarty.smart.net ([207.176.80.102]:13579 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S270048AbRHGD1d>;
	Mon, 6 Aug 2001 23:27:33 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200108070346.XAA03685@smarty.smart.net>
Subject: Re: /proc/<n>/maps growing...
To: linux-kernel@vger.kernel.org
Date: Mon, 6 Aug 2001 23:46:19 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I believe the best way is to allocate always the new vma, and to hide
>> the merging into the lowlevel of a new insert_vm_struct (with a special
>> function ala merge_segments that we can share with mprotect like in
>2.2).
>

Torvalds
>Oh, and THAT is going to speed things up?
>
>Hint: the merging actually happens at a fairly high percentage for the
>common cases. We win more by walking the tree twice and avoiding the

BROWNNOSE
No, I have nothing to say about malloc/mmap/etc. I just want to add some
balancing positiveness to offset my usual polemics. Torvalds harps on
optimizing for the common case all the time. This little voice with a
faint scandanavian accent in the back of my head keeps saying "optimize
for the common case". It is a wise little voice. The common case is
usually beyond the ken of a compiler, it's something a human has to
know, it works, can pay off huge, and works with anything from assembly
to Bash. 
END BROWNNOSE   
RESUME FLAMEBAIT

Rick Hohensee
						www.clienux.com
