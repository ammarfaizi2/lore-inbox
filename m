Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263442AbUDZTdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbUDZTdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUDZTdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:33:19 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:25865 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263442AbUDZTdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 15:33:18 -0400
Date: Mon, 26 Apr 2004 20:33:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org
Subject: Re: I oppose Chris and Jeff's patch to add an unnecessary additional namespace to ReiserFS
Message-ID: <20040426203314.A6973@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com, akpm@osdl.org
References: <1082750045.12989.199.camel@watt.suse.com> <408D3FEE.1030603@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <408D3FEE.1030603@namesys.com>; from reiser@namesys.com on Mon, Apr 26, 2004 at 09:59:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 09:59:26AM -0700, Hans Reiser wrote:
> The xattr namespace offers zero functional advantage over the file 
> namespace.  The use of '.' instead of '/' is idiotic, see the very short 
> paper "The Hideous Name" by Rob Pike  ( www.cs.bell-labs.com/cm/cs/doc/ 
> ) for why mindlessly varying the separators in hierarchical names 
> throughout an OS is a bad idea. 

Hans, where have you been the last three years?  Hiding under a rock?
If Linux wants to support additional attributes and ACLs they better
have a common API for _all_ filesystems.  People have discussed the xattr
issue to death, see the -fsdevel and acl-devel archives.  I haven't
seen you input anywhere, so better shut up now.

If you don't want to suport xattrs and acls at all in your filesystem
that's your business, but adding random new APIs is not.  If you want
your magic files included send them to -fsdevel, including how to
deal with them at the VFS level and using one set of entry points for
them and xattrs.  If not keep on dreaming your pipe dreams and don't
anoy us with your 'research' fantasies.

As for ACLs in v3 that's a decision of the maintainer, currently you're
the formal maintainer, but I don't remember a single patch from you.
Most of the linux 2.6 work has been done by Chris and quite a bit of
work by your employees.  Chris is paid for doing a stable and working
reiserfs variant for SuSE so he seems to be qualified for doing that, to..
