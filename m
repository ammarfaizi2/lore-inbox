Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131615AbQKNXmp>; Tue, 14 Nov 2000 18:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131768AbQKNXmf>; Tue, 14 Nov 2000 18:42:35 -0500
Received: from [213.8.185.152] ([213.8.185.152]:10761 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S131615AbQKNXmT>;
	Tue, 14 Nov 2000 18:42:19 -0500
Date: Wed, 15 Nov 2000 01:10:57 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test11-pre5
In-Reply-To: <3A11C1B6.E61FF9F6@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011150104250.26856-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, Jeff Garzik wrote:

> Dan Aloni wrote:
> > 
> > reason: Correct me if I'm wrong, but 3c501.c:init_module() calls
> > net_init.c:register_netdev(&dev_3c501), which calls strchr(),
> > {and might also,which might} dereference dev_3c501.name.
> 
> There is no dereferencing involved, and therefore no problem.

Well, at least I was alertive. Almost a bug fix ;-)
Is there a special reason why dev->name is not a pointer?

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
