Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUIMAfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUIMAfH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 20:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUIMAfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 20:35:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41118 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264396AbUIMAfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 20:35:01 -0400
Message-ID: <4144EB28.6070401@pobox.com>
Date: Sun, 12 Sep 2004 20:34:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch][0/6] ide: sanitize PIO code, take 2
References: <200409110026.20064.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200409110026.20064.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> - bugfix: use sg->length instead of sg_dma_len(sg)
>   (found thanks to rmk's concerns)

Details?

IIRC this breaks ia64 and/or other platforms?

	Jeff


