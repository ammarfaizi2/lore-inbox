Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVDYKJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVDYKJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 06:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVDYKJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 06:09:12 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:15515 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262569AbVDYKJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 06:09:09 -0400
To: bulb@ucw.cz
CC: jamie@shareable.org, viro@parcelfarce.linux.theplanet.co.uk,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050425072210.GC13975@vagabond> (message from Jan Hudec on Mon,
	25 Apr 2005 09:22:10 +0200)
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <E1DPwdo-0006xF-00@dorka.pomaz.szeredi.hu> <20050425072210.GC13975@vagabond>
Message-Id: <E1DQ0W9-0007Bu-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 25 Apr 2005 12:08:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They do. The *HAVE* to do! The 'session' stage modifies the environment,
> so it must be done after the fork. So if it, in addition to environment,
> modifies namespace, it won't make a difference.

That is good news.

So in theory it's doable.  Anyone willing to help putting it all
together?

Thanks,
Miklos
