Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbTEGWti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTEGWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:49:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32645
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263979AbTEGWth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:49:37 -0400
Subject: Re: [PATCH] 2.5 ide 48-bit usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b9bupr$jkm$2@tangens.hometree.net>
References: <20030507084920.GA823@suse.de>
	 <Pine.LNX.4.44.0305070915470.2726-100000@home.transmeta.com>
	 <20030507164613.GN823@suse.de>  <b9bupr$jkm$2@tangens.hometree.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052345009.3060.54.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 23:03:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-07 at 22:45, Henning P. Schmiedehausen wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> >I dunno what the purpose of that would be exactly, I guess to cater to
> >some hardware odditites?
> 
> Wild guess: You can use larger transfer sizes with the 48 bit
> interface, even when adressing the lower 28 bit space?

The ide-disk logic Jens did already switches to LBA48 for large requests
as well as requests high up on the disk

