Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310618AbSCHAcE>; Thu, 7 Mar 2002 19:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310619AbSCHAbq>; Thu, 7 Mar 2002 19:31:46 -0500
Received: from imo-r06.mx.aol.com ([152.163.225.102]:49604 "EHLO
	imo-r06.mx.aol.com") by vger.kernel.org with ESMTP
	id <S310618AbSCHAbk>; Thu, 7 Mar 2002 19:31:40 -0500
Date: Thu, 07 Mar 2002 19:31:25 -0500
From: pelletierma@netscape.net
To: linux-kernel@vger.kernel.org
Cc: adilger@clusterfs.com (Andreas Dilger)
Subject: RE: Re: ACL support
Message-ID: <558CD33A.5571E8D3.5016AB90@netscape.net>
X-Mailer: Atlas Mailer 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:

>On Mar 07, 2002  15:58 -0500, pelletierma@netscape.net wrote:
>> What I am offering is an alternative implementation of ACL support at the
>> VFS level, that remains independent of filesystem support for ACLs.
>
>Then you must not have looked at the bestbits.at code at all.  It includes
>a generic VFS interface for EAs and ACLs.  There are ext2, ext3, and XFS
>codes which work with this VFS interface.
>
>Some people have had complaints about the bestbits VFS interface, and
>another one for people to look at is never a bad thing.

That's my point.  :-)  I didn't say I have the /only/ interface in the VFS,
but that I'm proposing an /alternate/ interface at that level; in which
I do things a bits differently.  For one, I dissociate the attributes from
the ACL entirely; but that doesn't prevent the filesystem from implementing
one in terms of the other.

-- 




__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

