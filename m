Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRHVSkr>; Wed, 22 Aug 2001 14:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272077AbRHVSk1>; Wed, 22 Aug 2001 14:40:27 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:31412 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S272074AbRHVSkX>; Wed, 22 Aug 2001 14:40:23 -0400
Date: Wed, 22 Aug 2001 19:40:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: george anzinger <george@mvista.com>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), exit(), SIGCHLD)
Message-ID: <20010822194035.K18391@flint.arm.linux.org.uk>
In-Reply-To: <20010817125727.A16475@hq2> <3B7D76EF.DA34EB23@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B7D76EF.DA34EB23@mvista.com>; from george@mvista.com on Fri, Aug 17, 2001 at 12:56:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 12:56:31PM -0700, george anzinger wrote:
> Uh..?  I though that was what I was allowing.  It seems to me to be a
> lot of extra work to put the same code in 15 different archs. 
> Especially if one does not really know each of them, nor can any one
> group (or individual) be expected to be able to test (or even have the
> hardware to test) each of them.

Umm, my best advice is to look at sys_fork() and do_fork(), sys_execve()
and do_execve().

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

