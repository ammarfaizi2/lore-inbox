Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbTINRZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbTINRZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 13:25:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11496 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261254AbTINRZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 13:25:13 -0400
Message-ID: <3F64A46B.4050702@pobox.com>
Date: Sun, 14 Sep 2003 13:24:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Justin Cormack <justin@street-vision.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
References: <1063484193.1781.48.camel@mulgrave> <20030913212723.GA21426@gtf.org> <1063538182.1510.78.camel@lotte.street-vision.com> <20030914190121.G3371@pclin040.win.tue.nl>
In-Reply-To: <20030914190121.G3371@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Sun, Sep 14, 2003 at 12:15:27PM +0100, Justin Cormack wrote:
>>If you need to know your bootdisk (why?) why not just get the bootloader
>>to tell you?

> I am not quite sure why anybody would like to know what the bootdisk was.
> The rootdisk, yes, that we need. But the bootdisk?
> Finding it is nontrivial in general. Letting the bootloader tell us
> is also nontrivial.

The bootloader or mkinitrd typically tells the kernel what the root disk 
is, so that's not a big deal.  The boot disk, OTOH, is tough.  Right 
now, we just assume the sysadmin knows what's he's doing, when he 
installs lilo or grub on a disk.  You care about the boot disk when 
installing lilo... maybe there are similar situations too which I do not 
recall.  As Alan said, besides EDD (only on newer boxes) there's really 
nothing.

	Jeff



