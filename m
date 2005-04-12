Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVDLRQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVDLRQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVDLRO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:14:28 -0400
Received: from mail.shareable.org ([81.29.64.88]:29856 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262470AbVDLRNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:13:52 -0400
Date: Tue, 12 Apr 2005 18:13:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412171338.GA14633@mail.shareable.org>
References: <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu> <20050412164401.GA14149@mail.shareable.org> <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > Indeed, if it can be done with namespaces _and_ mounting on a file
> > (that file-as-directory concept), _and_ automounting, then you could
> > cd into your tgz files and others could too :)
> 
> There's still that little problem of accessing the tgz file both as a
> file and a directory.  But yes.  Maybe in 10 years time :)

There was a thread a few months ago where file-as-directory was
discussed extensively, after Namesys implemented it.  That's where the
conversation on detachable mount points originated AFAIR.  It will
probably happen at some point.

A nice implemention of it in FUSE could push it along a bit :)

-- Jamie

