Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbTF1BWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 21:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbTF1BWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 21:22:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5322 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265015AbTF1BWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 21:22:21 -0400
Message-ID: <3EFCF119.7000809@pobox.com>
Date: Fri, 27 Jun 2003 21:36:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Onur Kucuk <onur@kablonet.com.tr>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-ac4 & cm9739 & SATA
References: <3EFCD206.2020501@kablonet.com.tr>
In-Reply-To: <3EFCD206.2020501@kablonet.com.tr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Onur Kucuk wrote:
>    SATA (hde) is gone at 2.4.21-ac3 (and ac4), though system see it with 
> 2.4.20


> # CONFIG_SCSI_ATA is not set
> # CONFIG_SCSI_ATA_PIIX is not set


Though I didn't see it in his changelog, it looks like Alan merged my 
SATA driver.  Turn on the above two config options, and that should 
re-enable it.

	Jeff



