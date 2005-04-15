Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVDOSHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVDOSHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVDOSHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:07:46 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:18649 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S261892AbVDOSHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:07:36 -0400
Message-ID: <426003AB.3060904@shadowconnect.com>
Date: Fri, 15 Apr 2005 20:10:51 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Miquel van Smoorenburg <miquels@cistron.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec 2010S i2o + x86_64 doesn't work
References: <20050413160352.GA12841@xs4all.net>	 <1113576775.11116.17.camel@localhost.localdomain>	 <1113581722.14421.15.camel@zahadum.xs4all.nl> <1113587286.11114.30.camel@localhost.localdomain>
In-Reply-To: <1113587286.11114.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alan Cox wrote:
> On Gwe, 2005-04-15 at 17:15, Miquel van Smoorenburg wrote:
>>However, I removed 2 GB from the box as Alan sugggested and now the box
>>comes up just fine with a 64-bit 2.6.11.6 kernel! I've put the 4GB back,
>>and booted with the kernel "mem=2048" command line option - that also
>>works, the i2o_block driver sees the adaptec controller just fine.
>>And I just booted it with "mem=3840M" and that works too.
>>So the problem appears to be 4 GB memory in 64 bit mode, on this box.

OK, i never tried it with 4 GB so it really could be a problem...

> Or the driver is incorrectly handling 64/32bit DMA limit masks which
> would be my first guess here, and would explain why it works on AMD
> Athlon64 boxes.

Hmmm, i only set DMA_32BIT_MASK and don't do anything special on 64-bit 
systems... Is there anything else to do for correct DMA mapping?

Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
