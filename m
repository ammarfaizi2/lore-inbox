Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVGDJGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVGDJGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVGDJGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 05:06:54 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:3600 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261474AbVGDJDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 05:03:22 -0400
To: pavel@suse.cz
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-reply-to: <20050704084900.GG15370@elf.ucw.cz> (message from Pavel Machek on
	Mon, 4 Jul 2005 10:49:00 +0200)
Subject: Re: FUSE merging?
References: <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050630235059.0b7be3de.akpm@osdl.org> <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu> <20050701001439.63987939.akpm@osdl.org> <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu> <20050701010229.4214f04e.akpm@osdl.org> <20050703193941.GA27204@elf.ucw.cz> <E1DpMTJ-000639-00@dorka.pomaz.szeredi.hu> <20050704084900.GG15370@elf.ucw.cz>
Message-Id: <E1DpMqc-00065G-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 04 Jul 2005 11:02:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC restored]

> Okay, I just wanted to mention CODA. Modifying CODA is probably still
> better than modifying NFS (as akpm suggested at one point).

Definitely.

Here are some numbers on the size these filesystems as in current -mm
('wc fs/${fs}/* include/linux/${fs}*')

nfs:  25495
9p:    6102
coda:  4752
fuse:  3733

I'm sure FUSE came out smallest because I'm biased and did something
wrong ;)

Miklos
