Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288310AbSACUr1>; Thu, 3 Jan 2002 15:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288306AbSACUrR>; Thu, 3 Jan 2002 15:47:17 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:37136 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S288310AbSACUrE>;
	Thu, 3 Jan 2002 15:47:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Thu, 03 Jan 2002 15:35:19 CDT."
             <Pine.GSO.4.21.0201031532100.23693-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Jan 2002 07:46:49 +1100
Message-ID: <20733.1010090809@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002 15:35:19 -0500 (EST), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Thu, 3 Jan 2002, Dave Jones wrote:
>> And being able to NFS share 1 kernel tree, and be able to do parallel
>> builds on multiple boxes without having to wait until 1 is finished.
>
>	Sigh...  As soon as we get to prototype change in
>getattr()/setattr()/permission() - we get CoW fs.  I.e. equivalent of
>*BSD unionfs.  I hope to get around to that stuff around 2.5.4 or so.

Unionfs and cow fs will be nice but kernel build will not use it.
Users can build a Linux kernel on other operating systems, including
Solaris, Irix, Cygwin etc.  kbuild requires a Posix compliant fs and
GNU tools, but it must not use additional fs features that only exist
on Linux or only on specific versions of Linux.

