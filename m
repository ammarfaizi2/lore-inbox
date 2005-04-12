Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVDLP0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVDLP0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVDLPZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:25:00 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:1503 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262471AbVDLPUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:20:08 -0400
To: jamie@shareable.org
CC: 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412144529.GE10995@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 15:45:29 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3S8oN-So-15@gated-at.bofh.it> <3S8oN-So-17@gated-at.bofh.it> <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org>
Message-Id: <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 17:19:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the user wants to edit a read-only file in a tgz owned by himself,
> why can he not _chmod_ the file and _then_ edit it?
> 
> That said, I would _usually_ prefer that when I enter a tgz, that I
> see all component files having the same uid/gid/permissions as the tgz
> file itself - the same as I'd see if I entered a zip file.

I can accept that usually you are not interested in the stored
uid/gid.  But doubt that you want to lose permission information when
you mount a tar file.  Zip is a different kettle of fish since that
doesn't contain uid/gid/permissions.

Miklos
