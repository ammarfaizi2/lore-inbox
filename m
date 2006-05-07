Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWEGSrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWEGSrj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 14:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWEGSrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 14:47:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:13820 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751221AbWEGSrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 14:47:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [patch 0/6] New Generic HW RNG (#2)
Date: Sun, 7 May 2006 20:47:30 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
References: <20060507143806.465264000@pc1> <200605072039.08702.arnd@arndb.de> <200605072050.01719.mb@bu3sch.de>
In-Reply-To: <200605072050.01719.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605072047.31275.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 20:50, Michael Buesch wrote:
> 
> > It would be good to give the patches more descriptive names, currently
> > they all have the same subject lines, which is not really helpful.
> 
> How to do this with quilt?

Change the first line in each patch header to

Subject: <what this patch does>

> This has been discussed and it is not desired behaviour.
> If you want to feed /dev/random, use rngd to read from /dev/hwrng,
> validate the data and put it into /dev/random.

ok

	Arnd <><
