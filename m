Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUBAQfN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 11:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265364AbUBAQfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 11:35:13 -0500
Received: from smtp.vnoc.murphx.net ([217.148.32.26]:52976 "HELO
	mail-srv0.cluster.vnoc.murphx.net") by vger.kernel.org with SMTP
	id S265362AbUBAQfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 11:35:08 -0500
Message-ID: <401D2BDE.4020807@gadsdon.giointernet.co.uk>
Date: Sun, 01 Feb 2004 16:39:58 +0000
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040118
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] killing the AMD53C974 and mac_NCR5380 drivers
References: <fa.e2hfjs3.q3e2i3@ifi.uio.no>
In-Reply-To: <fa.e2hfjs3.q3e2i3@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I always had problems with the AMD53C974 driver even back in 2.2.x days. 
  On several old HP XU/90 and XU/120 Vectras I had to specify the 
TMSCSIM driver to get SCSI to work.....

Robert Gadsdon.

Christoph Hellwig wrote:
> Anyone screaming loudly if we remove them?
> 
>  - AMD53C974 is broken and doesn't even compile, all supported hardware is
>    handled by the mainted tmscsim driver.
>  - mac_NCR5380 isn't even referenced in the build and hasn't been at
>    least since 2.4
>                            
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

