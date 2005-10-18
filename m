Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVJROOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVJROOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJROOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:14:22 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:50737 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750746AbVJROOU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:14:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kwLlXBpKil3/5d1bmD3rvTWJm4gMO9KDPOG+fhzHnrmude+Etx7pQzZnOwFr6nybCXW6rqvoNu0fulBCwMLVvwOgKbqd1SJyCDk497q0eumQ+P8Mu1g1+tEDTKnDi5NSVxk/zjE+KWacIdRlfgK5MojYPS8x398oTTneHQZlOro=
Message-ID: <7a37e95e0510180714g348a1b15s5b78bd35ca0b6410@mail.gmail.com>
Date: Tue, 18 Oct 2005 19:44:19 +0530
From: Deven Balani <devenbalani@gmail.com>
To: erik@harddisk-recovery.com
Subject: Re: Why do we need libata to access SATA host controller low level device drivers?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051018134807.GB3843@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7a37e95e0510172114p6c2da139g5266e617fd9a7163@mail.gmail.com>
	 <20051018134807.GB3843@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The most appropriate answer is: "cause you don't want to reinvent the
> wheel". In order to get full SATA support, you only need to write a
> host driver, libata takes care of the gory details.
Thanks Erik for that useful suggestion.

> You don't want to use a 2.4 kernel on ARM, especially not when you're
> using new hardware. 2.4 is development is dead, everybody has moved to
> 2.6.
Since we already have Linux Kernel 2.4 based drivers for all the other
devices present on our ARM 920TDMI based chipset which we cannot
change. The SATA driver which I'm going to write has to be based on
Kernel 2.4.25. Through backported patches I have to make Kernel 2.4.25
to support our new SATA driver and as well our existing device
drivers.

Please do let me now if you have any suggestions in this regard.

Thanks:-),
Deven
