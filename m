Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbSJLTBv>; Sat, 12 Oct 2002 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbSJLTBv>; Sat, 12 Oct 2002 15:01:51 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:46267 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261319AbSJLTBv>; Sat, 12 Oct 2002 15:01:51 -0400
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>,
       <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [PATCH] 2.5.42: UML build error
References: <Pine.LNX.4.44.0210121330390.17947-100000@chaos.physics.uiowa.edu>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sat, 12 Oct 2002 21:07:16 +0200
In-Reply-To: <Pine.LNX.4.44.0210121330390.17947-100000@chaos.physics.uiowa.edu> (Kai
 Germaschewski's message of "Sat, 12 Oct 2002 13:31:30 -0500 (CDT)")
Message-ID: <878z13v5ln.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai-germaschewski@uiowa.edu> writes:

> On Sat, 12 Oct 2002, Olaf Dietsche wrote:
>
>> Though, it still gives one error right at the beginning:
>> 
>>   gcc -E -Wp,-MD,arch/um/.uml.lds.s.d_ -D__ASSEMBLY__ -D__KERNEL__ -Iinclude -nostdinc -iwithprefix include   -Ui386 -DSTART=$((0xc0000000 - ((0 + 1) * 0x20000000))) -DELF_ARCH=i386 -DELF_FORMAT=\"elf32-i386\" -P -C -Uum   -o arch/um/uml.lds.s arch/um/uml.lds.S 
>> /bin/sh: scripts/fixdep: No such file or directory
>> make: *** [arch/um/uml.lds.s] Error 1
>
> Try a "make scripts" first, that should work around it. I'll fix it 
> properly.

Works now, thanks.

Regards, Olaf.
