Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbUKPQtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUKPQtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUKPQsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:48:36 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:26783 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262041AbUKPQpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:45:33 -0500
To: greg@kroah.com
CC: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20041116163314.GA6264@kroah.com> (message from Greg KH on Tue,
	16 Nov 2004 08:33:14 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com>
Message-Id: <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 17:45:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, 'Documentation/devices.txt' says:
> > 
> >   THE DEVICE REGISTRY IS OFFICIALLY FROZEN FOR LINUS TORVALDS' KERNEL
> >   TREE.  At Linus' request, no more allocations will be made official
> >   for Linus' kernel tree; the 3 June 2001 version of this list is the
> >   official final version of this registry.
> 
> Not true, you can get new numbers.

I don't understand, what's the reason for this warning then?  To scare
away developers wanting to allocate lots of device numbers?

> Don't put things that should be in /dev into /proc, not allowed.
> 
> > So placing it in /proc doesn't seem to me such a bad idea.
> 
> No.  Actually, put it in sysfs, and then udev will create your /dev node
> for you automatically.  And in sysfs you can put your other stuff
> (version, etc.) which is the proper place for it.

I'll do that.

Thanks,
Miklos

