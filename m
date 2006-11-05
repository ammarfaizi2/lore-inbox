Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWKEXQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWKEXQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWKEXQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:16:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30607 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422777AbWKEXQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:16:39 -0500
Subject: Re: sc3200 cpu + apm module kernel crash
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas FR <nicolasfr@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b9481e140611051333p7250179ax6ba3629fcf0ad9e3@mail.gmail.com>
References: <b9481e140611031506u42e326dbs5c0e97d14c5fb5b3@mail.gmail.com>
	 <1162750917.31873.38.camel@localhost.localdomain>
	 <b9481e140611051333p7250179ax6ba3629fcf0ad9e3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Nov 2006 23:21:05 +0000
Message-Id: <1162768865.1566.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-11-05 am 22:33 +0100, ysgrifennodd Nicolas FR:
> The module was "crashing" on my box because it keeps on receiving
> events=APM_UPDATE_TIME meaning that it would never get out of the
> while() loop in check_events. I need to do some tests but I might

That's a BIOS bug

> simply fix this by ignoring APM_UPDATE_TIME events. I first thought

If that works can you run dmidecode on your box and post me the output,
from that we can add a blacklist entry to automatically handle this.


