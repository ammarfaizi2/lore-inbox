Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316820AbSF0MkU>; Thu, 27 Jun 2002 08:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSF0MkT>; Thu, 27 Jun 2002 08:40:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:6924 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316820AbSF0MkS>; Thu, 27 Jun 2002 08:40:18 -0400
Message-Id: <200206271236.g5RCahT08722@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: lgarfiel@students.depaul.edu, linux-kernel@vger.kernel.org,
       zaurus-general@lists.sourceforge.net
Subject: Re: [Zaurus-general] Re: New Zaurus Wishlist - removable media handling
Date: Thu, 27 Jun 2002 15:36:43 -0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.3.96.1020627032159.2332J-100000@pioneer> <3D1A7AB1.D4955601@students.depaul.edu>
In-Reply-To: <3D1A7AB1.D4955601@students.depaul.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2002 00:38, Larry Garfield wrote:
> What?  The unified file tree?  Yes, the unified file tree.  The idea
> that the silver plastic round thing you just put into the front of the
> computer is accessed.... "under" the "storage" in the computer?  Does
> that, conceptually, metaphorically, make sense?  No, it doesn't.

"Programmatically" it makes a lot of sense.

Do you see any fundamental difference in
A:\dir\dir
B:\dir\dir
 and
/mnt/auto/fd0/dir/dir
/mnt/auto/fd1/dir/dir
 from user POV?

> Nor
> does the need to explicitly "mount" and "umount" (the n having gotten
> lost while moving from one office to another a few years back) a floppy
> disk.  This is one place where, I hate to say it, drive letters a la
> DOS/Windows (or some other top-level identifier) are significantly
> better from a user perspective.

You can live without mount/umount. Automounter is your friend.

It is theoretically possible to teach filesystems to sync dirty
data to removable media ASAP and to cope with diskettes being removed without 
umount ("no disk? do we have diryt buffers? no? ok, implicit umount").
Who's volunteering to do that is an open question. :-)

I live with automounter with short umount timeout.
--
vda
