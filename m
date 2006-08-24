Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWHXO4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWHXO4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHXO4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:56:00 -0400
Received: from rtr.ca ([64.26.128.89]:17866 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932224AbWHXOz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:55:59 -0400
Message-ID: <44EDBDFD.6030908@rtr.ca>
Date: Thu, 24 Aug 2006 10:55:57 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>, marc@perkel.com
Subject: Re: Linux: Why software RAID?
References: <20060824090741.J30362@mail.kroptech.com> <1156425650.3007.140.camel@localhost.localdomain> <20060824093616.K30362@mail.kroptech.com>
In-Reply-To: <20060824093616.K30362@mail.kroptech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> On Thu, Aug 24, 2006 at 02:20:50PM +0100, Alan Cox wrote:
>> Generally speaking the channels on onboard ATA are independant with any
>> vaguely modern card. 
> 
> Ahh, I did not know that. Does this apply to master/slave connections on
> the same PATA cable as well?

No, it doesn't.  Except for cards which use special cables,
such as the Pacific Digital ADMA cards (which can even run both
master and slave simultaneously on a cable, though not with
the current Linux drivers).

Cheers
