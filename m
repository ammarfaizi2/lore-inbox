Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSFTVqI>; Thu, 20 Jun 2002 17:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFTVqH>; Thu, 20 Jun 2002 17:46:07 -0400
Received: from beach.cise.ufl.edu ([128.227.205.211]:50654 "EHLO
	mail.cise.ufl.edu") by vger.kernel.org with ESMTP
	id <S315611AbSFTVqG>; Thu, 20 Jun 2002 17:46:06 -0400
Date: Thu, 20 Jun 2002 17:46:07 -0400 (EDT)
From: Pradeep Padala <ppadala@cise.ufl.edu>
To: Andrew D Kirch <Trelane@Trelane.Net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ptrace vs /proc
In-Reply-To: <20020620163648.6d5e7955.Trelane@Trelane.Net>
Message-ID: <Pine.LNX.4.44.0206201742170.18444-100000@lin114-02.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux already posesses modular support for a /proc filesystem, every distribution, and I believe the stock kernel config includes support for this under the filesystems section by default.

I should have been clearer. I would like to know about the features ptrace 
supports like "system call tracing", "setting breakpoints" etc. 
Traditionally they were done through ptrace interface. In solaris and I 
guess in other operating systems like IRIX, they are moved to /proc 
interface. Applications wanting to trace programs like gdb, would use 
ioctl on the /proc/<pid> and trace the programs. 

As far as I could investigate, I didn't find any such interface in linux. 
Programs like strace do the tracing through ptrace only.

Please let me know if you know more about this.

--pradeep

