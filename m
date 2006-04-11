Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWDKGbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWDKGbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 02:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWDKGbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 02:31:31 -0400
Received: from web54314.mail.yahoo.com ([206.190.49.124]:47775 "HELO
	web54314.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932236AbWDKGba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 02:31:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4uTDwMYX64VROb+/RGLULXttRO6rF+5xOpIevxAa6e0qq2MnuWMF/VQnU9XI1Yhdi+2taJi7E+e2hupMDzTegdaZaNThDHbEdX4IHBFbJF28ySooIS/FqBVVoj5BQAsQ2Rv7qzQ/y/wsalB55gCGNu6Apnh1++/2go8Jr5gcOX8=  ;
Message-ID: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
Date: Mon, 10 Apr 2006 23:31:27 -0700 (PDT)
From: Ramakanth Gunuganti <rgunugan@yahoo.com>
Subject: GPL issues
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to understand the GPL boundaries for
Linux, any clarification provided on the following
issues below would be great:

As part of a project, I would like to extend the Linux
kernel to support some additional features needed for
the project, the changes will include:
  o  Modification to Linux kernel.
  o  Adding new kernel modules.
  o  New system calls/IOCTLs to use the kernel
modifications/LKMs.

All kernel changes including LKMs will be released
under GPL.

Questions:

(Any reference to GPL license while answering these
questions would be great)

1. If an application is built on top of this modified
kernel, should the application be released under GPL?
Do system calls provide a bounday for GPL? How does
this work with LKMs, all the code for LKMs will be
released but would a userspace application using the
LKMs choose not to use GPL?

2. If the application has to be packaged with the
Linux kernel, example: tarball that includes kernel +
application, can this application be released without
GPL. (The changes to Linux kernel are already released
under GPL).

3. How does this work if this application + kernel has
to run on a proprietary system on a seperate interface
card? Can I assume that once there is a clear hardware
boundary rest of the software for the system does not
have to be released under GPL? The software for the
interface card will be built and distributed
seperately from the rest of the software.

4. Can the GPL code and non-GPL code exist under the
same source tree?

5. In case of litigation, will there be pressure to
open up other parts of the software (non-GPL) running
on the same system but on other hardware components
interacting with this new package on a different
interface card?

Anyone trying to build a new application to work on
Linux must have these issues clarified, if you can
share your experiences that would be great too.

Thanks,
Ram


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
