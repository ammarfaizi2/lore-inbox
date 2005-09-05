Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVIEDy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVIEDy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVIEDy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:54:27 -0400
Received: from smtpout.mac.com ([17.250.248.85]:5606 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932185AbVIEDy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:54:26 -0400
In-Reply-To: <20050905034158.97152.qmail@web50213.mail.yahoo.com>
References: <20050905034158.97152.qmail@web50213.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2248681C-3D0F-4DA8-A882-9ECBBFB0247E@mac.com>
Cc: Sean <seanlkml@sympatico.ca>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Sun, 4 Sep 2005 23:54:04 -0400
To: Alex Davis <alex14641@yahoo.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 4, 2005, at 23:41:58, Alex Davis wrote:
> --- Sean <seanlkml@sympatico.ca> wrote:
>> It's not a philosophical issue, it's what Linux _is_: an open source
>> operating system! That's what the developers are working on; not your
>> half-baked vision.
> Um, ever hear of 'compromise'?? All I'm saying is let people use what
> currently works until we can get an open-source solution.  
> Ndiswrapper's
> existence is not stopping you (or anyone else) from pestering  
> manufacturers
> for spec's and writing drivers. I look at ndiswrapper as a stop-gap  
> solution.
> Hey, even Linus himself has said 'better a sub-optimal solution  
> than no solution'.

In any case, this discussion is moot because the kernel API is changing
for the better and there is a clearly defined fix for ndiswrapper that
will allow it to continue to work even with the new interface:  allocate
a separate ndiswrapper stack (IE: Not the kernel stacks).  The kernel is
under no obligation not to break out-of-tree drivers, etc, even semi- 
non-
-binary-only ones such as ndiswrapper.  Figure out how to fix it and
move on!

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.



