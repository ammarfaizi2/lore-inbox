Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbSKRSVI>; Mon, 18 Nov 2002 13:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKRSVI>; Mon, 18 Nov 2002 13:21:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3844 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262908AbSKRSVI>;
	Mon, 18 Nov 2002 13:21:08 -0500
Message-ID: <3DD9311A.3080006@pobox.com>
Date: Mon, 18 Nov 2002 13:27:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jordan.breeding@attbi.com
CC: linux-kernel@vger.kernel.org
Subject: Re: tco/rng support for Intel chipsets other than the i810?
References: <20021118175200.XMDP6492.rwcrmhc51.attbi.com@rwcrwbc71>
In-Reply-To: <20021118175200.XMDP6492.rwcrmhc51.attbi.com@rwcrwbc71>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jordan.breeding@attbi.com wrote:

> Do Intel chipsets other than the i810 have hardware support for 
> rng/tco drivers
> (i845, i860, E7500)?  If so will Linux be getting drivers for the tco/rng
> capabilities of those chipsets some time in the future?  Thanks.



WRT RNG, more than just i810 supports RNG, yes.  There are several 
chipset ids in i810_rng.c which are for later versions after i810.

So, the driver is perhaps misnamed at this point :) but it's not a huge 
deal, so I haven't renamed it to i8xx_rng.c.  :)

	Jeff



