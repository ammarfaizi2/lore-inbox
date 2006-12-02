Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162742AbWLBDHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162742AbWLBDHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 22:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162747AbWLBDHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 22:07:00 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:26106 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1162742AbWLBDG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 22:06:59 -0500
From: Ed Tomlinson <edt@aei.ca>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm2
Date: Fri, 1 Dec 2006 22:19:00 -0500
User-Agent: KMail/1.9.5
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org,
       akinobu.mita@gmail.com, jgarzik@pobox.com, Matt_Domsch@dell.com
References: <20061128020246.47e481eb.akpm@osdl.org> <200612011933.22029.edt@aei.ca> <20061201163248.f174bc0b.akpm@osdl.org>
In-Reply-To: <20061201163248.f174bc0b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612012219.01465.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 December 2006 19:32, Andrew Morton wrote:
> On Fri, 1 Dec 2006 19:33:21 -0500
> Ed Tomlinson <edt@aei.ca> wrote:
> 
> > I booted without the video and vga settings with earlyprintk=vga and got output.  The
> > kenerl was complaining about a crc error.  Checking the patch list I found:
> > 
> > crc32-replace-bitreverse-by-bitrev32.patch
> > 
> > reversing this patch fixes booting here.
> 
> Odd that you're the only person seeing this - could be a miscompile?

I recompiled four times.  The only change the last time was to reverse the above patch.  I am using
gcc is 4.1.1 (gentoo 4.1.1-r1).
 
> What was the error message, exactly?

I am not sure of the exact text.  Basicly the loader loaded the kernel, a crc error was reported, then the kernel halted.  
I am using grub, gcc 4.1.1 (Gentoo 4.1.1-r1).

