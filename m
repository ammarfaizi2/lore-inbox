Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280873AbRKBXVQ>; Fri, 2 Nov 2001 18:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280874AbRKBXVF>; Fri, 2 Nov 2001 18:21:05 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:58637 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280873AbRKBXUw>; Fri, 2 Nov 2001 18:20:52 -0500
Message-ID: <3BE32A4C.9F9DBCC3@linux-m68k.org>
Date: Sat, 03 Nov 2001 00:20:44 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Ashcraft <kash@stanford.edu>
CC: linux-kernel@vger.kernel.org, engler@stanford.edu
Subject: Re: null pointer questions
In-Reply-To: <Pine.GSO.4.33.0111021433590.6907-100000@saga18.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ken Ashcraft wrote:

> Why does it matter if 0 is a valid user space or not?  If I make the call
> 
> copy_from_user(0, user_ptr, 4);
> 
> the null pointer is the kernel address, not the user address.  Can you
> clarify please?

Sorry, I misunderstood you. The kernel address has to be a valid address
of course, otherwise the behavior is undefined.

bye, Roman
