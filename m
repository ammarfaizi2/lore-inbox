Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbUKPKZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbUKPKZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbUKPKZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:25:57 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:13454 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261762AbUKPKZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:25:55 -0500
To: dwmw2@infradead.org
CC: arjan@infradead.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1100600272.30283.27.camel@localhost.localdomain> (message from
	David Woodhouse on Tue, 16 Nov 2004 10:17:51 +0000)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	 <1100596704.2811.17.camel@laptop.fenrus.org>
	 <E1CTzpJ-0000ap-00@dorka.pomaz.szeredi.hu>
	 <1100598372.2811.21.camel@laptop.fenrus.org>
	 <E1CU00w-0000cM-00@dorka.pomaz.szeredi.hu> <1100600272.30283.27.camel@localhost.localdomain>
Message-Id: <E1CU0Wz-0000gH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 11:25:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > The lock guards the list not the list element which is being removed.
> 
> Locking rules like that need to be clearly documented.

OK, I'll add some comments. 

Thanks,
Miklos
