Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264893AbRGBMyc>; Mon, 2 Jul 2001 08:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264526AbRGBMyX>; Mon, 2 Jul 2001 08:54:23 -0400
Received: from t2.redhat.com ([199.183.24.243]:28401 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264893AbRGBMyG>; Mon, 2 Jul 2001 08:54:06 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3B406B63.4E28CA8A@cotw.com> 
In-Reply-To: <3B406B63.4E28CA8A@cotw.com>  <200107012207.PAA01921@adam.yggdrasil.com> 
To: sjhill@cotw.com
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: linux-2.4.6-pre8/drivers/mtd/nand/spia.c: undefined symbols 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 13:53:45 +0100
Message-ID: <27019.994078425@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sjhill@cotw.com said:
>  'spia.c' is the device dependent part. You should write your own
> version of 'spia.c' and "simply" fill in the addresses for the IO
> address and control register address depending on your specific
> hardware. The above symbols are only defined for my specific hardware.

Where are those four variables defined? In platform-dependent code for your 
board? If so, we should probably make the config option dependent on that 
platform. 

That'll make ESR whinge at me if support for your platform isn't (yet) in 
Linus' tree - but I don't care too much about that.

--
dwmw2


