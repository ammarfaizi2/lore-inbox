Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbUKQQnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbUKQQnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbUKQQku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:40:50 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62180 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262404AbUKQQjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:39:32 -0500
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	 <84144f0204111602136a9bbded@mail.gmail.com>
	 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
	 <20041116120226.A27354@pauline.vellum.cz>
	 <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100705768.419.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 15:36:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-16 at 14:01, Miklos Szeredi wrote:
> > "fuse/version" you have in /proc while it belongs to /proc
> > "fuse/dev"     you have in /proc while it belongs to /dev
> 
> Well, 'Documentation/devices.txt' says:
> 
>   THE DEVICE REGISTRY IS OFFICIALLY FROZEN FOR LINUS TORVALDS' KERNEL
>   TREE.  At Linus' request, no more allocations will be made official
>   for Linus' kernel tree; the 3 June 2001 version of this list is the
>   official final version of this registry.

This is just to keep Linus happy, every vendor on the planet ignores it
and co-operates with LANANA so that we have a single unified cross
vendor namespace and numbering scheme. The numbering matters a lot less
now with udev but the naming is critical to all the poor app and config
tool authors.

So LANANA is authoritative except for Linus computer 8)


