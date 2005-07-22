Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVGVLZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVGVLZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 07:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVGVLZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 07:25:59 -0400
Received: from [216.208.38.107] ([216.208.38.107]:9601 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S261246AbVGVLZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 07:25:57 -0400
Subject: Re: DriveStatusError BadCRC
From: Arjan van de Ven <arjan@infradead.org>
To: sampei02@tiscali.it
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D7AA0C000141C7@mail-8.mail.tiscali.sys>
References: <42D7AA0C000141C7@mail-8.mail.tiscali.sys>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 07:25:41 -0400
Message-Id: <1122031541.3577.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 10:27 +0200, sampei02@tiscali.it wrote:
> I bought new Maxtor HD 80 GB but somthing Fedora Core 3 crashes giving this
> 
> 
> message:
> 
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }

BadCRC tells you that there was a transmission error over the cable
between the disk and the controller. I'd recommend either trying a
different cable or reseating the existing one (and making sure it isn't
right over the cpu where it could overheat etc)

