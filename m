Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270253AbRHWUE6>; Thu, 23 Aug 2001 16:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270195AbRHWUEs>; Thu, 23 Aug 2001 16:04:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32507 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S270258AbRHWUEf>; Thu, 23 Aug 2001 16:04:35 -0400
Message-ID: <3B8561B9.AC440835@mvista.com>
Date: Thu, 23 Aug 2001 13:04:09 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Victor Yodaiken <yodaiken@fsmlabs.com>,
        "christophe =?iso-8859-1?Q?barb=E9?=" <christophe.barbe@lineo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), 
 exit(), SIGCHLD)
In-Reply-To: <20010817125727.A16475@hq2> <3B7D76EF.DA34EB23@mvista.com> <20010822194035.K18391@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Aug 17, 2001 at 12:56:31PM -0700, george anzinger wrote:
> > Uh..?  I though that was what I was allowing.  It seems to me to be a
> > lot of extra work to put the same code in 15 different archs.
> > Especially if one does not really know each of them, nor can any one
> > group (or individual) be expected to be able to test (or even have the
> > hardware to test) each of them.
> 
> Umm, my best advice is to look at sys_fork() and do_fork(), sys_execve()
> and do_execve().
> 
Sorry, but none of those system calls requires the registers which is
where the problem is.

George
