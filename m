Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTJCTXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 15:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTJCTXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 15:23:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262674AbTJCTXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 15:23:09 -0400
Message-ID: <3F7DCC84.9040909@pobox.com>
Date: Fri, 03 Oct 2003 15:22:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugo Mills <hugo-lkml@carfax.org.uk>
CC: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata support for Adaptec 1205SA?
References: <3F7D9C83.4050200@backtobasicsmgmt.com> <20031003174018.GA6628@carfax.org.uk>
In-Reply-To: <20031003174018.GA6628@carfax.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hugo Mills wrote:
>    I don't know for certain, *but* the AAR-1210SA definitely uses the
> SiI3112 chip (slightly mangled), and I'd be surprised if Adaptec used
> a different chip for the 1205SA. There's a picture of the 1210SA card

that's my suspicion too.


>>Does anyone here know, and more importantly, is libata ready to 
>>support it? I want to build a 6-drive SATA RAID using software RAID 5 
>>(can't just the expense of a 3ware card for this application), so I 
>>need to add four ports to the two already present on an ICH5 on the 
>>motherboard.
> 
> 
>    AFAIK, libata doesn't support SiI3112 yet. Jeff has promised it at
> some point -- possibly as the next SATA chip to support.

The driver is posted in the latest snapshot, but it's only for developer 
use right now...  need to acknowledge a few more interrupt events :)

	Jeff



