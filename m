Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266095AbTLaChR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 21:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266098AbTLaChR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 21:37:17 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:63483 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S266095AbTLaChQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 21:37:16 -0500
Date: Wed, 31 Dec 2003 03:35:01 +0100
To: Omkhar Arasaratnam <omkhar@rogers.com>
Cc: emoenke@gwdg.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/cdrom/isp16.c check_region() fix - take 2
Message-ID: <20031231023501.GB1982@mars>
References: <20031229220916.GA17210@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229220916.GA17210@omkhar.ibm.com>
User-Agent: Mutt/1.5.4i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 05:09:16PM -0500, Omkhar Arasaratnam wrote:
>  	printk(KERN_INFO
>  	       "ISP16: cdrom interface set up with io base 0x%03X, irq %d, dma %d,"
>  	       " type %s.\n", isp16_cdrom_base, isp16_cdrom_irq,
>  	       isp16_cdrom_dma, isp16_cdrom_type);
>  	return (0);
> +:out
> +	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
> +	return (-EIO);
>  }

s/:out/out:/

	Arthur
-- 
Linux is a true multitasking system. Are you?
