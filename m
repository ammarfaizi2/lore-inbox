Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267182AbSKML51>; Wed, 13 Nov 2002 06:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbSKML51>; Wed, 13 Nov 2002 06:57:27 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:60120 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267182AbSKML50>; Wed, 13 Nov 2002 06:57:26 -0500
Date: Wed, 13 Nov 2002 23:03:56 +1100
From: Michael Still <mikal@stillhq.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: Linux v2.5.47
In-Reply-To: <20021113002222.B323@infradead.org>
Message-ID: <Pine.LNX.4.30.0211132302050.6360-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Christoph Hellwig wrote:

> You can convert it easily into a new-style pci driver with the following
> probe routine:

Remembering of course that a scsi_register() can fail...

> 	[do basic setup]
> 	sdev = scsi_register();

        if(sdev == NULL){
          /* Handle error */
          }

> 	[do more setup]
> 	return scsi_add_host();

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com)     UTC +10 hours

