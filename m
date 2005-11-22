Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbVKVTwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbVKVTwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbVKVTwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:52:08 -0500
Received: from thunk.org ([69.25.196.29]:24965 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965157AbVKVTwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:52:07 -0500
Date: Tue, 22 Nov 2005 14:52:01 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Chris Adams <cmadams@hiwaay.net>, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122195201.GG31823@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Chris Adams <cmadams@hiwaay.net>, linux-kernel@vger.kernel.org
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net> <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk> <20051122171847.GD31823@thunk.org> <Pine.LNX.4.64.0511221921530.7002@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511221921530.7002@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 07:25:20PM +0000, Anton Altaparmakov wrote:
> > > The standards are insufficient however.  For example dealing with named 
> > > streams or extended attributes if exposed as "normal files" would 
> > > naturally have the same st_ino (given they are the same inode as the 
> > > normal file data) and st_dev fields.
> > 
> > Um, but that's why even Solaris's openat(2) proposal doesn't expose
> > streams or extended attributes as "normal files".  The answer is that
> > you can't just expose named streams or extended attributes as "normal
> > files" without screwing yourself.
> 
> Reiser4 does I believe...

Reiser4 violates POSIX.  News at 11....

> I was not talking about Solaris/UFS.  NTFS has named streams and extended 
> attributes and both are stored as separate attribute records inside the 
> same inode as the data attribute.  (A bit simplified as multiple inodes 
> can be in use for one "file" when an inode's attributes become large than 
> an inode - in that case attributes are either moved whole to a new inode 
> and/or are chopped up in bits and each bit goes to a different inode.)

NTFS violates POSIX.  News at 11....

							- Ted
