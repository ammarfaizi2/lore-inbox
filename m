Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132290AbRCWAaj>; Thu, 22 Mar 2001 19:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132292AbRCWAaa>; Thu, 22 Mar 2001 19:30:30 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:3713 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132290AbRCWAaT>; Thu, 22 Mar 2001 19:30:19 -0500
Message-ID: <3ABA986F.3816FB62@uow.edu.au>
Date: Fri, 23 Mar 2001 00:27:27 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.2-ac19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <200103230009.BAA22702@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> [+] Speaking as a hacker on a runtime system for a concurrent
> programming language (Erlang), I consider the current Unix/POSIX/Linux
> default of having the kernel throw up[*] at the user's current stack
> pointer to be unbelievably broken. sigaltstack() and SA_ONSTACK should
> not be options but required behaviour.
> 

Why?  What problem does stack puke cause?
