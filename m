Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbUKQPmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUKQPmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUKQPmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:42:50 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:23729 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262347AbUKQPms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:42:48 -0500
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20041116163314.GA6264@kroah.com> (message from Greg KH on Tue,
	16 Nov 2004 08:33:14 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com>
Message-Id: <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Nov 2004 16:42:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No.  Actually, put it in sysfs, and then udev will create your /dev node
> for you automatically.  And in sysfs you can put your other stuff
> (version, etc.) which is the proper place for it.

Next question: _where_ to put other stuff?  In /proc this has a
logical place for filesystems: /proc/fs/fsname/other_stuff.  But
there's no filesystem section in sysfs.

So?

Thanks,
Miklos
