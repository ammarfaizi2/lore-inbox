Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271349AbRHTQ0d>; Mon, 20 Aug 2001 12:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271342AbRHTQ0X>; Mon, 20 Aug 2001 12:26:23 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:681 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S271360AbRHTQ0M>; Mon, 20 Aug 2001 12:26:12 -0400
Date: Mon, 20 Aug 2001 11:26:13 -0500
From: Dave McCracken <dmc@austin.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.9 Make thread group id visible in
 /proc/<pid>/status
Message-ID: <26210000.998324773@baldur>
In-Reply-To: <E15Yrlh-0006JF-00@the-village.bc.nu>
In-Reply-To: <E15Yrlh-0006JF-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, August 20, 2001 17:19:13 +0100 Alan Cox 
<alan@lxorguk.ukuu.org.uk> wrote:

> I didnt think anyone was using the broken tgid stuff ?

I was under the impression that the current LinuxThread library does use 
CLONE_THREAD, and I know of at least one project under way that's also 
using it (the NGPT pthread library).  The getpid() system call already 
returns tgid instead of pid.  I'm also looking into what's involved in 
making tgid more robust.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmc@austin.ibm.com                                      T/L   678-3059

