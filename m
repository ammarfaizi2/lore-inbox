Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTJ0NxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 08:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbTJ0NxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 08:53:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17059 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263069AbTJ0NxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 08:53:15 -0500
Message-ID: <3F9D233D.6000409@pobox.com>
Date: Mon, 27 Oct 2003 08:53:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaun Savage <savages@savages.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
References: <3F9D196C.9080301@savages.net>
In-Reply-To: <3F9D196C.9080301@savages.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaun Savage wrote:
> I have just compiled and installed kernel 2.6t9 on my RH9 / Asus A7N8X 
> Deluxe.  I find the disk access is slower using the 2.6 kernel than the 
> 2.4.20 kernel.
> 
> To get it to work for 2.4.20 kernel I have to use
> # hdparm -d1 -X88 /dev/hde
> then the buffered disk read goes from 1.5M to 55M
> 
> On the 2.6 kernel the buffered disk read is only 16M
> 
> What do I have to do to increase the disk speed for kernel 2.6t9?


Are you using CONFIG_SCSI_SATA in 2.6?

	Jeff



