Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310193AbSCEUek>; Tue, 5 Mar 2002 15:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310199AbSCEUeW>; Tue, 5 Mar 2002 15:34:22 -0500
Received: from imo-m02.mx.aol.com ([64.12.136.5]:65488 "EHLO
	imo-m02.mx.aol.com") by vger.kernel.org with ESMTP
	id <S310193AbSCEUeB>; Tue, 5 Mar 2002 15:34:01 -0500
Date: Tue, 05 Mar 2002 15:32:52 -0500
From: pelletierma@netscape.net
To: linux-kernel@vger.kernel.org
Subject: ACL support.
Message-ID: <1E348DA0.50E5770A.5016AB90@netscape.net>
X-Mailer: Atlas Mailer 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've given a swing at ACL support for the linux kernel.  Kernel patches and userland support is avaliable for review at

http://sourceforge.net/projects/linux-acl/

I'm looking for complaints, praise, suggestions, and bug reports.  :-)  Since I'm unfamiliar with non-i386 entry.S, I've not yet added the system calls to other architectures, though.  Sorry.

I'm on a slow link, so I can't subscribe to the mailing list and remain sane simultaneously.  Please cc: comments to me; or post on the sourceforge project forums.

If you people think this is a Bad Idea(tm) to begin with, just tell me.  :-)

-- Marc A. Pelletier

-- Original annoucement follows --

Initial release of Linux ACL support.

Somethings to dig your security teeth into: ACL support for the Linux kernel.

Access Control Lists allow fine grained access control to filesystem objects, by attaching a list of permissions to grant or deny specific capabilities to users or groups.
This implementation of ACL for the Linux kernel provides semantics that are almost totally compatible with the traditional POSIX umode model for applications that are unaware of the kernel support.

Features include the ability to set rights for fine grained operation on filesystem objects (such as separate write/truncate/append permissions) to an arbitary number of users or groups; and the ability to "offer" a file for chown()ing by another user.

Currently, using the package requires patching and recompiling your kernel, and installing tools to use the new features, thus requiring some kernel-fu savvy.

Once development has reached a stable, reliable state and has been well tested, the kernel patch aspect will be submitted for inclusion in the main kernel sources.

Testers are welcome, and peer review of the security aspects of the code are welcome, and desired.


-- 




__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

