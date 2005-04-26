Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVDZKBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVDZKBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVDZKBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:01:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:32188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261439AbVDZKBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:01:19 -0400
Date: Tue, 26 Apr 2005 03:00:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-Id: <20050426030010.63757c8c.akpm@osdl.org>
In-Reply-To: <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu>
References: <3WWZG-3AC-7@gated-at.bofh.it>
	<3X630-2qD-21@gated-at.bofh.it>
	<3X8HA-4IH-15@gated-at.bofh.it>
	<3Xagd-5Wb-1@gated-at.bofh.it>
	<E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
	<1114445923.4480.94.camel@localhost>
	<20050425191015.GC28294@mail.shareable.org>
	<E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu>
	<20050426091921.GA29810@infradead.org>
	<E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu>
	<20050426093628.GA30208@infradead.org>
	<E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > > define "mount owner".  Right now mount requires CAP_SYS_ADMIN which means
>  > > > fairly privilegued.
>  > > 
>  > > FUSE uses a suid root helper (as explained below).  Please read the
>  > > whole mail.
>  > 
>  > In that case you're totally out of luck.  This is not a setup we want to
>  > account for.
> 
>  Christoph, you are being thickheaded,

Not as thick as mine!  Could someone please explain in small words what's
wrong with an suid mount helper?
