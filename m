Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267895AbUGWTBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267895AbUGWTBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 15:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267897AbUGWTBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 15:01:09 -0400
Received: from web50609.mail.yahoo.com ([206.190.38.248]:30576 "HELO
	web50609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267895AbUGWTBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 15:01:05 -0400
Message-ID: <20040723190104.48863.qmail@web50609.mail.yahoo.com>
Date: Fri, 23 Jul 2004 12:01:04 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Ext3 problems in dual booting machine with SE Linux
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0407231333000.4446@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You may have hit either the 2.4/2.6 xattr compatibility bug, or some other
>xattr bug since fixed in the kernel.  I'd suggest using a 2.4.25 or
>greater kernel if you want to access ext2/ext3 xattrs which were created
>under 2.6.  2.4 kernels below this do not have 2.6 compatible xattrs for
>ext2 and ext3.

If Ext3 is now no longer compatible with itself, should it have been called Ext4?


Is there any version number embedded in the filesystem so newer versions of Ext3
can act in a way compatible with older systems? 

This seems like an open door to mischief. Any removable media can now be used to
oops a kernel. There are systems that are under configuration control and moving
to 2.4.25 is not really an option. They should be able to read/write any ext3
media inserted into them.

Also look at the 2nd question in section 1.3 of the Fedora Core 2 SE Linux FAQ
page. It does not say using SE Linux will massively corrupt your system when you
reboot into non-selinux systems.

-Steve Grubb


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
