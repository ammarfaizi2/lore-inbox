Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWHQIZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWHQIZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWHQIZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:25:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2733 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932165AbWHQIZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:25:55 -0400
Subject: Re: /dev/sd*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Lee Trager <Lee@PicturesInMotion.net>, Jeff Garzik <jeff@garzik.org>,
       Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <44E42198.3030500@tls.msk.ru>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060809212124.GC3691@stusta.de>
	 <1155160903.5729.263.camel@localhost.localdomain>
	 <20060809221857.GG3691@stusta.de>
	 <20060810123643.GC25187@boogie.lpds.sztaki.hu>
	 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
	 <44E42198.3030500@tls.msk.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 09:42:23 +0100
Message-Id: <1155804143.15195.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 11:58 +0400, ysgrifennodd Michael Tokarev:
> The reason, in my opinion anyway, is that not all the word is IDE now,
> and it has been this way for a long time.  I mean, real scsi uses /dev/sd*
> *right now*, and changing this to /dev/disk* will break just everything,
> not only people using IDE.

If people would like their disks to appear in /dev/disk/ by label or
whatever just send Greg some udev rules for it. It isnt a kernel problem
what it is called just some of the things around partitions

