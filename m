Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271687AbTHDJUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 05:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271692AbTHDJUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 05:20:16 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:31688 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271687AbTHDJUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 05:20:14 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 4 Aug 2003 11:13:02 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm2: BTTV build error
Message-ID: <20030804091302.GH24453@bytesex.org>
References: <20030730223810.613755b4.akpm@osdl.org> <20030731150648.GG22991@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731150648.GG22991@fs.tum.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +bttv-driver-update.patch

>   CC      drivers/media/video/bttv-cards.o
> drivers/media/video/bttv-cards.c: In function `pvr_boot':
> drivers/media/video/bttv-cards.c:2549: error: incompatible types in 
> initialization
> drivers/media/video/bttv-cards.c:2552: warning: implicit declaration of 
> function `request_firmware'

Hmm, must investigate.  Any change if you toggle CONFIG_FW_LOADER?

catching up one week email backlog,

  Gerd

-- 
sigfault
