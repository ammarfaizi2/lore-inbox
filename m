Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbUKEOIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbUKEOIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbUKEOIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:08:55 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:61164 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262695AbUKEOIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:08:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lGENdf0rPf8c+ZIaCpBoE54aarBWaU9lKKJrha8hQimtBVw6BrEX9E1qf2IqdTxks3uylWQJ5JCfXEDsOFlpJfZ2jroC5AhTjazkEnxJz6cssEigTWQtRJu2SYUsoB+0NksvGhuHUgPPhNUTVnYqO6pWLQhAqQvYjpsonylL2X0=
Message-ID: <58cb370e041105060837f6c555@mail.gmail.com>
Date: Fri, 5 Nov 2004 15:08:53 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ide-scsi: DMA alignment bug fixed
Cc: Terry Kyriacopoulos <terryk@echo-on.net>, linux-kernel@vger.kernel.org,
       gadio@netvision.net.il, andre@linux-ide.org, linu-ide@vger.kernel.org
In-Reply-To: <20041105073556.GE16649@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.56.0411050042250.88@vk.local>
	 <20041105073556.GE16649@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ linux-ide@vger.kernel.org added to cc: ]

Before going further please both of you check the current -linus tree.

I fixed ide-scsi to "pass" scatterlist table obtained from
SCSI layer to IDE layer and killed BIO mapping completely.

Thanks.

Jens, while unaligned DMA is a problem for ide-scsi?
AFAIR ide-cd does it so this is not a hardware limitation...

Bartlomiej
