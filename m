Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266583AbRGSFQL>; Thu, 19 Jul 2001 01:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRGSFQB>; Thu, 19 Jul 2001 01:16:01 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:18763 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S266583AbRGSFPy>; Thu, 19 Jul 2001 01:15:54 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rick Hohensee <humbubba@smarty.smart.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: cpuid_eax damages registers (2.4.7pre7) 
In-Reply-To: Your message of "Wed, 18 Jul 2001 16:30:55 -0400."
             <200107182030.QAA23313@smarty.smart.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Jul 2001 15:15:40 +1000
Message-ID: <32457.995519740@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2001 16:30:55 -0400 (EDT), 
Rick Hohensee <humbubba@smarty.smart.net> wrote:
>>We should try to find a work-around.
>
>>> >  - do a "make arch/i386/kernel/setup.s" both ways, and show what
>
>Is there a way to do a "make bla/zay/woof.c "  and save the woof.s ?

rm bla/zay/woof.o
make CFLAGS_woof.o=-save-temps

