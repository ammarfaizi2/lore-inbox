Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTICQnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTICQnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:43:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44474 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263846AbTICQnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:43:07 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] IDE: Enable LED support for PowerMac
Date: Wed, 3 Sep 2003 18:43:59 +0200
User-Agent: KMail/1.5
Cc: Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1062605698.1780.33.camel@gaston>
In-Reply-To: <1062605698.1780.33.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031843.59366.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 03 of September 2003 18:14, Benjamin Herrenschmidt wrote:
> Hi Bart !

Hi Ben !

> @@ -993,6 +1000,15 @@
>
>  endchoice
>
> +config BLK_DEV_IDE_STB04xxx
> +	bool "STB04xxx (Redwood-5) IDE support"
> +	depends on BLK_DEV_IDE && REDWOOD_5
> +	help
> +	  This option provides support for IDE on IBM STB04xxx Redwood-5
> +	  systems.
> +
> +	  If unsure, say N.
> +

Whats this?  I am dropping this chunk.

--bartlomiej

