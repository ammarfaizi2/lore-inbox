Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280699AbRKBOQD>; Fri, 2 Nov 2001 09:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280702AbRKBOPw>; Fri, 2 Nov 2001 09:15:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:58382 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280700AbRKBOPm>; Fri, 2 Nov 2001 09:15:42 -0500
Message-ID: <3BE2B704.247E4050@evision-ventures.com>
Date: Fri, 02 Nov 2001 16:08:52 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
In-Reply-To: <2211.1004709304@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Fri, 02 Nov 2001 13:39:29 +0100,
> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> >Bull shit. Standard policy is currently to keep crude old
> >interfaces until no end of time. Here are some examples:
> >...
> >/proc/ksyms - this is duplicating a system call (and making stuff easier
> >for intrusors)
> 
> Anybody can issue syscall query_module.  Removing /proc/ksyms just
> forces users to run an executable or Perl syscall().  You have not
> improved security and you have made it harder to report and diagnose
> problems.

Talking about reality:

Having perl on the box, or having to upload some special purpose
application on the box are both measures not that easy if you are
going to do a real breakin. (Read: write some buffer overflow stub)
But just echo sum stuff or therelike is
*much* easier. And then there is the capability stuff you could use
to prevent everybody from accessing the syscall interface.

You don't have much expierence with real break-ins. Don't you?
