Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRCWCRY>; Thu, 22 Mar 2001 21:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRCWCRP>; Thu, 22 Mar 2001 21:17:15 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:62555 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129509AbRCWCRF>; Thu, 22 Mar 2001 21:17:05 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Andrew Morton" <morton@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac21 
In-Reply-To: Your message of "Fri, 23 Mar 2001 01:50:49 -0000."
             <3ABAABF9.294E89BD@asiapacificm01.nt.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Mar 2001 13:16:18 +1100
Message-ID: <6054.985313778@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001 01:50:49 +0000, 
"Andrew Morton" <morton@nortelnetworks.com> wrote:
>Keith Owens wrote:
>> 
>> Am I the only person who is annoyed that nmi watchdog is now off by
>> default and the only way to activate it is by a boot parameter?  You
>> cannot even patch the kernel to build a version that has nmi watchdog
>> on because the startup code runs out of the __setup routine, no boot
>> parameter, no watchdog.
>
>It was causing SMP boxes to crash mysteriously after
>several hours or days.  Quite a lot of them.  Nobody
>was able to explain why, so it was turned off.

I know why it was turned off by default.  The annoying this is that now
the *only* way to activate the watchdog is via a boot command.  It is
not possible to compile a standard debugging kernel with this option
turned on, you have to rely on every user setting the boot options for
every kernel.  If it is going to be off by default there should be a
way to patch the kernel to make it on by default.

