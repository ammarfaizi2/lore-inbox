Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRDWH7o>; Mon, 23 Apr 2001 03:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRDWH7d>; Mon, 23 Apr 2001 03:59:33 -0400
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:42374 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S131481AbRDWH7Z>; Mon, 23 Apr 2001 03:59:25 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: ebiederman@lnxi.com (Eric W. Biederman)
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Longstanding elf fix (2.4.3 fix) 
In-Reply-To: Message from ebiederman@lnxi.com (Eric W. Biederman) 
   of "23 Apr 2001 01:44:57 MDT." <m3snj0giva.fsf@DLT.linuxnetworx.com> 
In-Reply-To: <m31yqk8oas.fsf@DLT.linuxnetworx.com> <15075.40500.408470.152332@pizda.ninka.net>  <m3snj0giva.fsf@DLT.linuxnetworx.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Apr 2001 08:59:20 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14rbFg-0007JZ-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And of course since much of the code in the kernel is built on the
>copy a good example neglecting the locking without a big comment,
>invites trouble elsewhere like in elf_load_library.  Where we could
>have multiple threads running.  

Out of interest: does anything, anywhere, actually use elf_load_library any 
more?

p.


