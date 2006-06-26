Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWFZHAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWFZHAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 03:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWFZHAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 03:00:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751192AbWFZHAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 03:00:45 -0400
Date: Mon, 26 Jun 2006 00:00:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Leech <christopher.leech@intel.com>
Subject: Re: In function =?ISO-8859-1?B?X19faW9hdF9pbml0X21vZHVsZV9fXzo=?=
 2.6.17-mm2 -- In function =?ISO-8859-1?B?X19faW9hdF9pbml0X21vZHVsZV9fXzo=?=
 drivers/dma/ioatdma.c:828: error: dereferencing pointer to incomplete type
Message-Id: <20060626000041.deb8f20d.akpm@osdl.org>
In-Reply-To: <a44ae5cd0606252339v51cada26x6ab23da155e1dea5@mail.gmail.com>
References: <a44ae5cd0606252339v51cada26x6ab23da155e1dea5@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 23:39:34 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

>   CC      drivers/dma/ioatdma.o
> drivers/dma/ioatdma.c: In function 'ioat_init_module':
> drivers/dma/ioatdma.c:828: error: dereferencing pointer to incomplete type
> make[2]: *** [drivers/dma/ioatdma.o] Error 1

Known (and oft-reported) bug.  The driver will only compile as a module.
