Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTLESnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTLESmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:42:50 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:65261 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S264313AbTLESmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:42:42 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: "David Schwartz" <davids@webmaster.com>
Date: Fri, 05 Dec 2003 10:44:03 -0800
MIME-Version: 1.0
Subject: RE: Linux GPL and binary module exception clause? 
CC: <linux-kernel@vger.kernel.org>
Message-ID: <3FD06173.4829.4801EFD4@localhost>
In-reply-to: <MDEHLPKNGKAHNMBLJOLKMEIDIHAA.davids@webmaster.com>
References: <200312050513.hB55D1ps030713@turing-police.cc.vt.edu>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> wrote:

> > That's 6,288 chances for you to #include GPL code and end up
> > with executable derived from it in *your* .o file, not the kernel's.
> 
>  I'm sorry, but that just doesn't matter. The GPL gives you the
> unrestricted right to *use* the original work. This implicitly
> includes the right to peform any step necessary to use the work.
> (This is why you can 'make a copy' of a book on your retina if you
> have the right to read it.) Please tell me how you use a kernel
> header file, other than by including it in a code file, compiling
> that code file, and executing the result. 

Another point worth mentioning is that if the Linux kernel headers are 
pure GPL, then user land programs that use the Linux kernel headers 
themselves would also be pure GPL by extension if the above argument 
holds water. Clearly the Linux developers would like to believe 
otherwise, but there are many Linux user mode programs that will make use 
of GPL kernel headers in their non-GPL programs. And some of that code 
will include inline assembler and inline functions to make calls into the 
kernel.

Likewise, by extension, any runtime library that uses GPL header files 
from the kernel directly would have to also be pure GPL. This means glibc 
folks. We all know glibc is LGPL, but if you link pure GPL code with LGPL 
code the entire work must be *GPL*, not LGPL if it is considered a 
derived work.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

