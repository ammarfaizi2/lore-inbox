Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTLETXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTLETXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:23:38 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:34176 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S264372AbTLETXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:23:35 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Valdis.Kletnieks@vt.edu
Date: Fri, 05 Dec 2003 11:25:01 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause? 
CC: linux-kernel@vger.kernel.org
Message-ID: <3FD06B0D.23426.482772AC@localhost>
In-reply-to: <200312051909.hB5J9fps019007@turing-police.cc.vt.edu>
References: Your message of "Fri, 05 Dec 2003 10:44:02 PST." <3FD06172.28193.4801EF18@localhost> 
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> On Fri, 05 Dec 2003 10:44:02 PST, Kendall Bennett said:
> 
> > Right, and by extension of the same argument you cannot use kernel
> > headers to create non-GPL'ed binaries that run IN USER SPACE! Just
> > because a program runs in user space does not mean that it is not a
> > dervived work. 
> 
> That's a bad idea for technical reasons too - how often do we have
> to tell people not to use kernel headers from userspace? 
> glibc-kernheaders (and whatever non-RedHat boxes call it) exists
> for a reason. 
> 
> Interestingly enough, at least on my Fedora box, 'rpm -qi' reports
> glibc as LGPL, but glibc-kernheaders as GPL, which seems right to
> me - linking against glibc gives the LGPL semantics as we'd want,
> but forces userspace that's poking in the kernel to be GPL as a
> derived work.... 

If glibc-kernheaders (used only if you do not have real kernel source 
code installed) is GPL, and many of the standard Linux include files end 
up including either headers from glibc-kernheaders (or the real Linux 
kernel source if you have it installed and symlinked), then by extension 
the glibc library built for Linux must be GPL as would all programs 
linked against it.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

