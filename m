Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVBFPDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVBFPDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 10:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVBFPDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 10:03:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32730 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261164AbVBFPDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 10:03:45 -0500
Message-ID: <420631BF.7060407@pobox.com>
Date: Sun, 06 Feb 2005 10:03:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com>	 <1107682076.22680.58.camel@laptopd505.fenrus.org>	 <58cb370e050206044513eb7f89@mail.gmail.com>  <42062BFE.7070907@pobox.com> <1107701373.22680.115.camel@laptopd505.fenrus.org>
In-Reply-To: <1107701373.22680.115.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>I consider it not a new feature, but a missing feature, since otherwise 
>>user data cannot be accessed in the RAID setups.
> 
> 
> the same is true for all new hardware drivers and hardware support
> patches. And for new DRM (since new X may need it) and new .. and
> new ... where is the line?
> 
> for me a deep maintenance mode is about keeping existing stuff working;
> all new hw support and derivative hardware support (such as this) can be
> pointed at the new stable series... which has been out for quite some
> time now..

Red herring.

2.4.x has ICH5/6 support -- but is missing the RAID support component.

We are talking about hardware that is ALREADY supported by 2.4.x kernel, 
not new hardware.

We are also talking about inability to access data on hardware supported 
by 2.4.x, not something that can easily be ignored or papered over with 
a compatibility mode.

	Jeff


