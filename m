Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTJIOC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTJIOC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:02:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44006 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262190AbTJIOC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:02:57 -0400
Message-ID: <3F856A7E.2010607@pobox.com>
Date: Thu, 09 Oct 2003 10:02:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] laptop mode
References: <200310091103.h99B31ug014566@hera.kernel.org>
In-Reply-To: <200310091103.h99B31ug014566@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1150.1.52, 2003/10/08 10:49:45-03:00, axboe@suse.de
> 
> 	[PATCH] laptop mode
> 	
> 	Hi Marcelo,
> 	
> 	Lots of people have been using this patch with great success, and it's
> 	been in the SuSE kernel for some months now too. It is also in the -benh
> 	ppc tree
> 	
> 	Basically, it introduces a write back mode of dirty and journal data
> 	that is more suitable for laptops. At the block layer end, it schedules
> 	write out of dirty data after the disk has been idle for 5 seconds.
> 	
> 	Laptop mode can be switched on and off with /proc/sys/vm/laptop_mode.
> 	There is also a block_dump sysctl, which if enabled will dump who
> 	dirties and writes out data. This is very helpful in pinning down who is
> 	causing unnecessary writes to the disk.

Red Hat just dropped this patch since it was suspected of data 
corruption ;-(

	Jeff



