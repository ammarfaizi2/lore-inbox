Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265967AbUFTWUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbUFTWUg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUFTWUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:20:36 -0400
Received: from main.gmane.org ([80.91.224.249]:51601 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265966AbUFTWUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:20:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [PATCH] FAT: don't use "utf8" charset and NLS_DEFAULT
Date: Mon, 21 Jun 2004 00:09:32 +0200
Message-ID: <MPG.1b402989dd27af149896d0@news.gmane.org>
References: <200406201807.i5KI7qNT004770@hera.kernel.org> <1087767944.2805.20.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-20-141.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2004-06-20 at 18:59, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1770, 2004/06/20 09:59:33-07:00, hirofumi@mail.parknet.co.jp
> > 
> > 	[PATCH] FAT: don't use "utf8" charset and NLS_DEFAULT
> > 	
> > 	Recently, some distributors have set "utf8" to NLS_DEFAULT, therefore,
> > 	FAT uses the "iocharset=utf8" as default.  But, since "iocharset=utf8"
> > 	doesn't provide the function (lower <-> upper conversion) which FAT
> > 	needs, so FAT can't provide suitable behavior.
> 
> does Microsoft store UTF8 in vfat ?

Long names are UTF16-encoded IIRC.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

