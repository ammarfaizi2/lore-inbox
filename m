Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWAGD4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWAGD4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWAGD4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:56:05 -0500
Received: from rtr.ca ([64.26.128.89]:7560 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030331AbWAGD4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:56:04 -0500
Message-ID: <43BF3BB5.6060201@rtr.ca>
Date: Fri, 06 Jan 2006 22:55:33 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove drivers/net/tulip/xircom_tulip_cb.c
References: <20060106192123.GB12131@stusta.de> <1136575714.2940.73.camel@laptopd505.fenrus.org>
In-Reply-To: <1136575714.2940.73.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2006-01-06 at 20:21 +0100, Adrian Bunk wrote:
> 
>>This patch removes the obsolete drivers/net/tulip/xircom_tulip_cb.c 
>>driver.
..
> NACK... xircom_cb (while written by me and thus purrrrrfect, doesn't
> work for everyone). This chip is so f*cked up that it may not even be
> possible to get all the variants working with only 1 driver ;-(

Agreed (regretably).

The cardbus Xircom 10/100 + (real)modem cards only ever worked
for me using the xircom_tulip_cb driver.  Best to keep both drivers.

Sadly, I recently sold my ancient notebook, and the card went with it.

-ml
