Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUITTqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUITTqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUITTqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:46:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62953 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266073AbUITTqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:46:13 -0400
Message-ID: <414F3377.9080106@pobox.com>
Date: Mon, 20 Sep 2004 15:45:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mikem@beardog.cca.cpqcorp.net, mike.miller@hp.com
CC: linux-kernel@vger.kernel.org, axboe@suse.de, linux-scsi@vger.kernel.org
Subject: Re: fix for cpqarray for 2.6.9-rc2
References: <20040920192420.GA5651@beardog.cca.cpqcorp.net>
In-Reply-To: <20040920192420.GA5651@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com wrote:
> diff -burNp lx269-rc2.orig/drivers/block/ida_cmd.h lx269-rc2/drivers/block/ida_cmd.h
> --- lx269-rc2.orig/drivers/block/ida_cmd.h	2004-08-14 00:36:44.000000000 -0500
> +++ lx269-rc2/drivers/block/ida_cmd.h	2004-09-20 14:15:39.782595128 -0500
> @@ -318,6 +318,8 @@ typedef struct {
>  	__u8	reserved[510];
>  } mp_delay_t;
>  
> +#define SENSE_SURF_STATUS       0x70


I guess the return codes for this op are along the lines of "calm", 
"bitchin", and "gnarly"?

	Jeff


