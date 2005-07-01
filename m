Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263242AbVGAGv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263242AbVGAGv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 02:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbVGAGvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 02:51:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263242AbVGAGvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 02:51:54 -0400
Date: Thu, 30 Jun 2005 23:50:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: aia21@cam.ac.uk, arjan@infradead.org, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-Id: <20050630235059.0b7be3de.akpm@osdl.org>
In-Reply-To: <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<20050630022752.079155ef.akpm@osdl.org>
	<E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	<1120125606.3181.32.camel@laptopd505.fenrus.org>
	<E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	<1120126804.3181.34.camel@laptopd505.fenrus.org>
	<1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	<20050630124622.7c041c0b.akpm@osdl.org>
	<E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>  > - aren't we going to remove the nfs semi-server feature?
> 
>  I leave the decision to you ;)  It's a separate independent patch
>  already (fuse-nfs-export.patch).

Let's leave it out - that'll stimulate some activity in the
userspace-nfs-server-for-FUSE area.

Speaking of which, dumb question: what does FUSE offer over simply using
NFS protocol to talk to the userspace filesystem driver?
