Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTBEP7v>; Wed, 5 Feb 2003 10:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTBEP7v>; Wed, 5 Feb 2003 10:59:51 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:14824 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261302AbTBEP7u> convert rfc822-to-8bit; Wed, 5 Feb 2003 10:59:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide write barriers
Date: Wed, 5 Feb 2003 16:28:48 +0100
User-Agent: KMail/1.4.3
Cc: Chris Mason <mason@suse.com>
References: <20030205151859.GK31566@suse.de>
In-Reply-To: <20030205151859.GK31566@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302051628.48803.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 February 2003 16:18, Jens Axboe wrote:

Hi Jens,

> The attached patch implements write barrier operations in the block
> layer and for IDE, specifically. The goal is to make the use of write
> back cache enabled ide drives safe with journalled file systems.
> Patch is against 2.4.21-pre4-bk as of today, and includes a small patch
> to enable it on ext3. Chris has a patch for reiserfs as well.
Could you also please cook up one for 2.4.20? :) Thank you.

ciao, Marc
