Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbTIHTol (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTIHTol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:44:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:27080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263563AbTIHTok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:44:40 -0400
Date: Mon, 8 Sep 2003 12:41:49 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Mathieu LESNIAK <maverick@eskuel.net>
cc: <linux-kernel@vger.kernel.org>, <pavel@ucw.cz>
Subject: Re: Fs corruption with swsusp in test4-mm6 ?
In-Reply-To: <3F59A913.1080406@eskuel.net>
Message-ID: <Pine.LNX.4.33.0309081239400.972-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've tested the latest -mm6 kernel on a Compaq Presario 2157EA laptop 
> (Celeron Mobile 2GHz)
> Everything worked fine until I tested suspend to disk. After resuming, 
> I've got random messages about reiserfs problem on the console :

Definitely not good. 

> vs-4080: reiserfs_free_block: free_block (hda2:95121)[dev:blocknr]: bit 
> already cleared
> Sep  6 10:30:51 herrbach kernel: vs-4080: reiserfs_free_block: 
> free_block (hda2:95122)[dev:blocknr]: bit already cleared
> Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
> of object [689 645 0x0 SD] (nlink == 1) not found (pos 25)
> Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
> of object [689 652 0x0 SD] (nlink == 1) not found (pos 25)

Could someone that is familar with reiserfs comment as to what exactly is 
happening? 

Mathieu, did you notice this with any of the earlier -test4-mm6 kernels, 
or just -mm6? 

Thanks,


	Pat

