Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbUCYRXD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbUCYRXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:23:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40621 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263500AbUCYRT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:19:26 -0500
Message-ID: <4063148F.8080009@pobox.com>
Date: Thu, 25 Mar 2004 12:19:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fabian Fenaut <fabian.fenaut@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial ATA status
References: <20040325171038.D8316991E6@majesty.pobox.com>
In-Reply-To: <20040325171038.D8316991E6@majesty.pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Fenaut wrote:
> On Thu, 2004-02-26 at 03:34, Jeff Garzik wrote:
> 
>  > Silicon Image 3112/3114
>  > -----------------------
>  >
>  > libata driver status:  Alpha.
>  >
>  > drivers/ide driver status:  Production, but see issue #4.
>  >
>  > Issue #4:  Need to have the most recent fixes posted to lkml, for stable
>  > operation and full performance (where possible).
> 
> 
> Is the libata driver still considered as alpha ? Are you progressively 
> updating some documentation on the sata drivers status ?

Given my recent work in bug fixing, and in isolating some problems to 
the platform rather than libata, the Silicon Image driver will be moving 
to beta, and the CONFIG_BROKEN marker removed, as soon as 2.6.5 kernel 
is out.

With the latest patches, I would say status of sata_sil is now "beta".

To answer your other question, yes, I progressive update the document 
you quoted to reflect updates in the status of the various drivers.

	Jeff




