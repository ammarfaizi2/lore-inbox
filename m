Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310591AbSCGX0V>; Thu, 7 Mar 2002 18:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310594AbSCGX0M>; Thu, 7 Mar 2002 18:26:12 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:6138 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S310591AbSCGXZ7>; Thu, 7 Mar 2002 18:25:59 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 7 Mar 2002 16:25:25 -0700
To: pelletierma@netscape.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACL support
Message-ID: <20020307162525.A1566@turbolinux.com>
Mail-Followup-To: pelletierma@netscape.net, linux-kernel@vger.kernel.org
In-Reply-To: <3EA14851.578E6D9E.5016AB90@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA14851.578E6D9E.5016AB90@netscape.net>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 07, 2002  15:58 -0500, pelletierma@netscape.net wrote:
> In response to a number of email I have received, I wanted to make
> something clear:  I'm not out to compete with the bestbit implementation of 
> ACLs over extended file attributes.  :-)
> 
> What I am offering is an alternative implementation of ACL support at the
> VFS level, that remains independent of filesystem support for ACLs.

Then you must not have looked at the bestbits.at code at all.  It includes
a generic VFS interface for EAs and ACLs.  There are ext2, ext3, and XFS
codes which work with this VFS interface.

Some people have had complaints about the bestbits VFS interface, and
another one for people to look at is never a bad thing.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

