Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbTIOXtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTIOXtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:49:15 -0400
Received: from mrout1.yahoo.com ([216.145.54.171]:47889 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S261739AbTIOXtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:49:12 -0400
Message-ID: <3F664FED.4040609@bigfoot.com>
Date: Mon, 15 Sep 2003 16:49:01 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-ac3
References: <200309152306.h8FN6lF04552@devserv.devel.redhat.com>
In-Reply-To: <200309152306.h8FN6lF04552@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This one should be treated gently initially.
> 
> Linux 2.4.22-ac3
...
> o	Add lba48_pio handling				(me)
> 	| Large disks on controllers that can do PIO LBA48 or DMA LBA28
> 	| now switch to PIO for large disks, not fail

   does this apply to SATA disks?

   what's the status of support for 137GB+ SATA disks? it required 
libata5 patches from Jeff Garzik before (as of 2.4.21-ac4). I see some 
SATA and ata related patches but I can't tell whether those are 
(equivalent of) libata5. I'd appreciate some status update (of course a 
pointer to where/how to find it would be appreciated too)

   TIA

	erik

