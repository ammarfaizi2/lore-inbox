Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbUKPURR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUKPURR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUKPUN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:13:59 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:44680 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261795AbUKPUMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:12:07 -0500
To: aia21@cam.ac.uk
CC: jengelh@linux01.gwdg.de, greg@kroah.com,
       rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <Pine.LNX.4.60.0411161941100.20464@hermes-1.csi.cam.ac.uk>
	(message from Anton Altaparmakov on Tue, 16 Nov 2004 19:42:29 +0000
	(GMT))
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com>
 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz>
 <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com>
 <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com>
 <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu> <20041116175857.GA9213@kroah.com>
 <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.53.0411162023001.24131@yvahk01.tjqt.qr>
 <E1CU94I-0007YH-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.60.0411161941100.20464@hermes-1.csi.cam.ac.uk>
Message-Id: <E1CU9gG-0007ca-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 21:12:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you didn't mistype above this means there is space for 115 and NOT just 
> 15 dynamic devices and that ought to be plenty for you.

But unfortunately I did mistype, and it's really only 15.

> btw.  On a different subject, does fuse allow several user space 
> filesystems at the same time or only one?

There's no limit on the number of mounted FUSE filesystems.  And only
one device is needed, since the mount is bound to the opened file
descriptor.

Miklos
