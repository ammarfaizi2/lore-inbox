Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267924AbUHUVO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267924AbUHUVO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267847AbUHUVOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:14:00 -0400
Received: from ebiz-gw.wintek.com ([206.230.1.186]:12928 "EHLO
	dust.ebiz-gw.wintek.com") by vger.kernel.org with ESMTP
	id S267931AbUHUVLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:11:11 -0400
Date: Sat, 21 Aug 2004 16:11:41 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Lei Yang <leiyang@nec-labs.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
In-Reply-To: <4127B49A.6080305@nec-labs.com>
Message-ID: <Pine.LNX.4.61.0408211609170.6808@dust.ebiz-gw.wintek.com>
References: <4127A15C.1010905@nec-labs.com> <20040821214402.GA7266@mars.ravnborg.org>
 <4127A662.2090708@nec-labs.com> <20040821215055.GB7266@mars.ravnborg.org>
 <4127B49A.6080305@nec-labs.com>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004, Lei Yang wrote:

> What about multi-file module?
>
> Say test.c doesn't include stdio.h, while there is some other .c file which 
> is to be compiled and linked into test.ko, include stdio?
>
> Would that work?
>
> TIA!
> Lei

You can't use userspace headers in the kernel.  That's why the kernel has 
its own set with things like printk(), etc, etc.  What is it that you're 
trying to do and why does it need file i/o?

-- 
Alex Goddard
agoddard at purdue dot edu
