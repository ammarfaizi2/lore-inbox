Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbTLETON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTLETOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:14:12 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:23424 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S264367AbTLETOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:14:06 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Jesse Pollard <jesse@cats-chateau.net>
Date: Fri, 05 Dec 2003 11:15:11 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause?
CC: <linux-kernel@vger.kernel.org>
Message-ID: <3FD068BF.29544.481E7373@localhost>
References: <MDEHLPKNGKAHNMBLJOLKAEJHIHAA.davids@webmaster.com>
In-reply-to: <03120508594500.21696@tabby>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <jesse@cats-chateau.net> wrote:

> It is if you are referring to the Kernel. Look at the include
> files. They are licened under GPL. 
> 
> Look at the include files for applications. They are licenced
> under LGPL. 

Really? Have you looked at the include files for Linux? The standard C 
include files that nearly every program uses will end up also *including* 
Linux kernel header files in order to build programs for Linux. Not all 
programs will end up including those files, but a very large portion 
will.

If you don't believe me, do a grep under /usr/include/sys on your machine 
for 'linux', and see how many of the header files include stuff from 
/usr/include/linux. All the files under /usr/include/linux are part of 
the kernel, so theoretically under the pure GPL, not LGPL.

Then again I say 'theoretically' because once again there is nary a 
kernel header file in sight that actually *has* a GPL license header 
attached! So who knows what license those files are *really* under.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

