Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbUKPT4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbUKPT4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUKPTv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:51:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42427 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261777AbUKPTtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:49:05 -0500
Date: Tue, 16 Nov 2004 20:48:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Miklos Szeredi <miklos@szeredi.hu>, greg@kroah.com,
       rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <Pine.LNX.4.60.0411161941100.20464@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.53.0411162048140.8374@yvahk01.tjqt.qr>
References: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com>
 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz>
 <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com>
 <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com>
 <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu> <20041116175857.GA9213@kroah.com>
 <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.53.0411162023001.24131@yvahk01.tjqt.qr>
 <E1CU94I-0007YH-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.60.0411161941100.20464@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If you didn't mistype above this means there is space for 115 and NOT just
>15 dynamic devices and that ought to be plenty for you.
no, but misunderstood. it's clear now.
>
>btw.  On a different subject, does fuse allow several user space
>filesystems at the same time or only one?

20:48 io:../fuse-1.9/util # df -Ta
Filesystem    Type   1K-blocks      Used Available Use% Mounted on
[...]
lt-fusexmp    fuse    34337852  16626616  17711236  49% /mnt/fuji
lt-fusexmp    fuse    34337852  16626616  17711236  49% /mnt/mmc
lt-hello      fuse           0         0         0   -  /mnt/smc

Yes, seems so.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
