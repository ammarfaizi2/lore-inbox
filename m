Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVBCWtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVBCWtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVBCWTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:19:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23477 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261692AbVBCWPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:15:05 -0500
Message-ID: <4202A25A.9050700@pobox.com>
Date: Thu, 03 Feb 2005 17:14:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: via82cxxx resume failure.
References: <1105953931.26551.314.camel@hades.cambridge.redhat.com> <58cb370e05020312296060f4bf@mail.gmail.com>
In-Reply-To: <58cb370e05020312296060f4bf@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Sorry for the delay.
> 
> On Mon, 17 Jan 2005 09:25:30 +0000, David Woodhouse <dwmw2@infradead.org> wrote:
> 
>>On resume from sleep, via_set_speed() doesn't reinstate the correct DMA
>>mode, because it thinks the drive is already configured correctly. This
>>one-line hack is sufficient to make it refrain from dying a horrible
>>death immediately after resume, but presumably has other problems...
> 
> 
> I applied this to libata-dev so it gets some testing in -mm.

Chuckle -- you mean ide-dev, presumably :)

	Jeff



