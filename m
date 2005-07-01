Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263357AbVGAOcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbVGAOcb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 10:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbVGAOcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 10:32:31 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:3347 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263357AbVGAOc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 10:32:28 -0400
To: ericvh@gmail.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com,
       v9fs-developer@lists.sourceforge.net
In-reply-to: <a4e6962a05070107183862ed22@mail.gmail.com> (message from Eric
	Van Hensbergen on Fri, 1 Jul 2005 09:18:59 -0500)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	 <20050630235059.0b7be3de.akpm@osdl.org>
	 <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	 <20050701001439.63987939.akpm@osdl.org>
	 <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <20050701010229.4214f04e.akpm@osdl.org>
	 <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
	 <a4e6962a050701062136435471@mail.gmail.com>
	 <E1DoLxK-0002ua-00@dorka.pomaz.szeredi.hu> <a4e6962a05070107183862ed22@mail.gmail.com>
Message-Id: <E1DoMYJ-0002ya-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 16:31:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What would people say if ext3 was always mounted locally through NFS,
> > because the kernel would only provide the NFS filesystem client.
> 
> Probably the same thing they would say if ext3 was a user-space
> application that always needed to be mounted via FUSE ;)

Yes, and rightly.

One of the misunderstandings about userspace filesystems (Linus falls
into this) is to compare it with microkernels.

FUSE (and userspace filesystems in general) are NOT meant to replace
in kernel filesystems or the VFS.  They are an addition with which
different kinds of filesystems can be implemented much better than
they could be in kernel.

Miklos
