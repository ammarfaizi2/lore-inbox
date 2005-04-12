Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVDLRIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVDLRIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVDLRIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:08:06 -0400
Received: from mail.shareable.org ([81.29.64.88]:25760 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262266AbVDLQoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:44:14 -0400
Date: Tue, 12 Apr 2005 17:44:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412164401.GA14149@mail.shareable.org>
References: <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> The same can be true for tarfs.  I mount it for my purpose, others can
> mount it for theirs.  Since the daemon providing the filesystem asways
> runs with the same capabilities as the user who did the mount, I and
> others will always get the permissions that we have on the actual tar
> file.

Fair enough.

> Think of the "no permission for others" as "hiding", not as some
> special permission rule.  And if this hiding can be nicely done with
> namespaces, all the better, I'll happily drop this feature at that
> instant.

Indeed, if it can be done with namespaces _and_ mounting on a file
(that file-as-directory concept), _and_ automounting, then you could
cd into your tgz files and others could too :)

-- Jamie
