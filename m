Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751851AbWHUKpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWHUKpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWHUKpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:45:35 -0400
Received: from ms-smtp-01.tampabay.rr.com ([65.32.5.131]:21653 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751851AbWHUKpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:45:34 -0400
Message-ID: <44E98ECB.3040603@cfl.rr.com>
Date: Mon, 21 Aug 2006 06:45:31 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Luka Marinko <luka.marinko@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: question on pthreads
References: <3420082f0608201046q53bb60b5u5ca8915e588ee9e3@mail.gmail.com> <ecakcv$m06$1@sea.gmane.org> <1156112486.10565.64.camel@mindpipe>
In-Reply-To: <1156112486.10565.64.camel@mindpipe>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sun, 2006-08-20 at 21:32 +0000, Luka Marinko wrote:
>> You can find nice manual here, and overview
>> http://www.gnu.org/software/libc/manual/html_mono/libc.html
>>
> 
> Unfortunately the NPTL documentation is FAR from complete - there are no
> man pages at all, and some featured are completely undocumented.  For
> example process-shared mutexes are supported, but the only way you'd
> know is to look at the source.  The only docs I could find on how to use
> them were old Solaris man pages.
> 
> Lee
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

glibc 2.4.31 has a man page for it.

PTHREAD_MUTEXATTR_GETPSHARED(P)                                 POSIX
Programmer's Manual                                PTHREAD_MUTEXATTR_GETPSHARED(P)



NAME
       pthread_mutexattr_getpshared, pthread_mutexattr_setpshared - get and set
the process-shared attribute

SYNOPSIS
       #include <pthread.h>

       int pthread_mutexattr_getpshared(const pthread_mutexattr_t *
              restrict attr, int *restrict pshared);
       int pthread_mutexattr_setpshared(pthread_mutexattr_t *attr,
              int pshared);

Mark
