Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbUKQRl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUKQRl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbUKQRjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:39:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8359 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262422AbUKQRiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:38:14 -0500
Date: Wed, 17 Nov 2004 18:38:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nikita Danilov <nikita@clusterfs.com>
cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <16795.35688.634029.21478@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.53.0411171837250.15704@yvahk01.tjqt.qr>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
 <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
 <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
 <20041116163314.GA6264@kroah.com> <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
 <16795.33515.187015.492860@thebsh.namesys.com> <Pine.LNX.4.53.0411171809490.24190@yvahk01.tjqt.qr>
 <16795.35688.634029.21478@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >mount -tfoo_ctrlfs -o host=/mnt/point /mnt/control-point
> >
> > Looks to me like a pollution of the mount table if you do this on a lot of
> > filesystems.
>
>If you have a lot of file-systems your mount table is already polluted.

That does not justify to pollute with *_ctlfs it
to double the size it already is.


