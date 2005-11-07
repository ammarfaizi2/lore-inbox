Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVKGKmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVKGKmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVKGKmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:42:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:39929 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750991AbVKGKmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:42:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH 18/25] raw: move ioctl32 code to raw.c
Date: Mon, 7 Nov 2005 11:43:44 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       axboe@suse.de
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162718.128174000@b551138y.boeblingen.de.ibm.com> <20051106135917.GC3847@stusta.de>
In-Reply-To: <20051106135917.GC3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511071143.45481.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 06 November 2005 14:59, Adrian Bunk wrote:
> On Sat, Nov 05, 2005 at 05:27:08PM +0100, Arnd Bergmann wrote:
> 
> > The two ioctl commands for the raw driver are not used
> > anywhere outside of raw.c, so move the compat handler
> > there as well.
> >...
> 
> Please leave this alone, the raw driver will be removed in 2.6.16.

Ok, good point.

	Arnd <><
