Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265562AbRGCHRY>; Tue, 3 Jul 2001 03:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbRGCHRO>; Tue, 3 Jul 2001 03:17:14 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:17263 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S265562AbRGCHRE>; Tue, 3 Jul 2001 03:17:04 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Sean Hunter <sean@dev.sportingbet.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5 
In-Reply-To: Your message of "Tue, 03 Jul 2001 07:50:50 +0100."
             <20010703075050.B15457@dev.sportingbet.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jul 2001 17:16:48 +1000
Message-ID: <2122.994144608@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001 07:50:50 +0100, 
Sean Hunter <sean@dev.sportingbet.com> wrote:
>Does this defeat my favourite module-related gothcha, that the machine panics
>if I have (say) a scsi driver builtin to the kernel and the same driver tries
>to load itself as a module?

No, but other wip for 2.5 will.  My 2.5 makefile rewrite already
defines for each object, the module it would be linked into if it were
a module.  That gives me a list of all the "modules" already in the
kernel which is what is required to prevent duplicate loads.

