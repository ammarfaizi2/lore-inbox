Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbSJOLwZ>; Tue, 15 Oct 2002 07:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262490AbSJOLwZ>; Tue, 15 Oct 2002 07:52:25 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:35332 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262482AbSJOLwZ>; Tue, 15 Oct 2002 07:52:25 -0400
Date: Tue, 15 Oct 2002 12:58:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: tytso@mit.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015125816.A22877@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E181IS8-0001DQ-00@snap.thunk.org>; from tytso@mit.edu on Mon, Oct 14, 2002 at 11:33:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:33:04PM -0400, tytso@mit.edu wrote:
> Linus,
> 
> 	Enclosed please find patches to add extended attribute support
> to the ext2 and ext3 filesystems.  It is a port of Andreas Gruenbacher's
> patches, which have been quite well tested at this point.  Full support
> for extended attributes have been in e2fsprogs for quite some time.  In
> addition, if CONFIG_EXT[23]_FS_ATTR is not enabled, the code path
> changes are quite minimal, and hence this should be a very low-risk
> patch.  Please apply.
> 
> These patches are a prerequisite for the port of Andreas Gruenbacher's
> ACL patches, which will follow shortly.
> 
> This first patch creates a generic interface for registering caches with
> the VM subsystem so that they can react appropriately to memory
> pressure.

It doesn't look like you addressed any comments raised, i.e. my
complaints or sct's superblock fields.  I"ll start feeding some updates
to akpm to address a few issues, but I don't really have time to
care of all that.  

