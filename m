Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVDZKRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVDZKRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVDZKRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:17:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:32191 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261443AbVDZKO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:14:58 -0400
Date: Tue, 26 Apr 2005 03:14:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, hch@infradead.org, jamie@shareable.org,
       linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-Id: <20050426031414.260568b5.akpm@osdl.org>
In-Reply-To: <20050426100412.GA30762@infradead.org>
References: <3Xagd-5Wb-1@gated-at.bofh.it>
	<E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
	<1114445923.4480.94.camel@localhost>
	<20050425191015.GC28294@mail.shareable.org>
	<E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu>
	<20050426091921.GA29810@infradead.org>
	<E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu>
	<20050426093628.GA30208@infradead.org>
	<E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu>
	<20050426030010.63757c8c.akpm@osdl.org>
	<20050426100412.GA30762@infradead.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Apr 26, 2005 at 03:00:10AM -0700, Andrew Morton wrote:
> > Not as thick as mine!  Could someone please explain in small words what's
> > wrong with an suid mount helper?
> 
> Nothing per-se.  What makes it bad is the contect of a userland filesystem
> where the actual filesystem operations in the mounted filesystem happen
> in contect of a non-privilegued user.

That's one of the major points of FUSE, isn't it?  So that unprivileged
users can do interesting things.

Or are you saying that that's a desirable objective, but it should be
implemented differently?

