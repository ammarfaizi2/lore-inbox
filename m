Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422937AbWAMUlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422937AbWAMUlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422938AbWAMUlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:41:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:32764 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1422937AbWAMUlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:41:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 1/13] s390: des crypto code cleanup.
Date: Fri, 13 Jan 2006 20:40:55 +0000
User-Agent: KMail/1.9.1
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
References: <20060112171404.GB16629@skybase.boeblingen.de.ibm.com> <20060113125808.GA1868@elf.ucw.cz>
In-Reply-To: <20060113125808.GA1868@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200601132040.55599.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 12:58, Pavel Machek wrote:
> On Čt 12-01-06 18:14:04, Martin Schwidefsky wrote:
> > From: Jan Glauber <jan.glauber@de.ibm.com>
> > 
> Why does s390 need to do des in arch-specific code, BTW? Is it driver
> for some crypto accelerator or what?

Yes, newer s390 have CPU instructions for DES and a few other encryption
standards.

	Arnd <><
