Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbUKPTe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbUKPTe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbUKPTdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:33:49 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:24039 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262118AbUKPTa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:30:27 -0500
To: greg@kroah.com
CC: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20041116191643.GA10021@kroah.com> (message from Greg KH on Tue,
	16 Nov 2004 11:16:43 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com> <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu> <20041116175857.GA9213@kroah.com> <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu> <20041116191643.GA10021@kroah.com>
Message-Id: <E1CU91x-0007Xw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 20:30:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Depends on what your /dev node is trying to do.  What is is doing
> anyway? 

Filesystem requests are passed to userspace and the reply is send back
to the kernel.  So it's definitely a character device or socket like
thing.

> Any ioctls?  Any wierd, non-chardev like things?

Nothing extraordinary.  Messages are sent/received with plain read and
write.

> Again, inline code would have been nice to see so those of us who live
> in our email clients could have reviewed it...

Next time I'll try to split it up in managable parts, and send it
inline.

Thanks,
Miklos
