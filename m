Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315609AbSECJBX>; Fri, 3 May 2002 05:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315610AbSECJBW>; Fri, 3 May 2002 05:01:22 -0400
Received: from zok.SGI.COM ([204.94.215.101]:2770 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315609AbSECJBW>;
	Fri, 3 May 2002 05:01:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Fri, 03 May 2002 00:54:27 +0200."
             <20020502225426.GB22246@elf.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 19:00:15 +1000
Message-ID: <9853.1020416415@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002 00:54:27 +0200, 
Pavel Machek <pavel@ucw.cz> wrote:
>kaos wrote
>> Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
>> It is faster, better documented, easier to write build rules in, has
>> better install facilities, allows separate source and object trees, can
>> do concurrent builds from the same source tree and is significantly
>> more accurate than the existing kernel build system.
>
>Significantly more accurate, or actually *acurate* as in "never
>forgets to rebuild anything"?
>									Pavel
>PS: Okay, modulo bugs...

Never forgets to rebuild anything, modulo bugs.  I would like to claim
100% build accuracy but ... "All code has at least one bug".

If you make a change and the kernel does not rebuild correctly, that is
a severity 1 bug in kbuild 2.5 and I will fix it.

