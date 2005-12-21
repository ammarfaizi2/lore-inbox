Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVLUNQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVLUNQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVLUNQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:16:27 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:53420 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932403AbVLUNQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:16:26 -0500
Message-ID: <43A955CC.4030101@ru.mvista.com>
Date: Wed, 21 Dec 2005 16:17:00 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI:  async message handing library update
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051215151948.497d703b.vwool@ru.mvista.com> <200512181059.14301.david-b@pacbell.net>
In-Reply-To: <200512181059.14301.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

>			if (t->len) {
>				/* FIXME if bitbang->use_dma, dma_map_single()
>				 * before the transfer, and dma_unmap_single()
>				 * afterwards, for either or both buffers...
>				 */
>  
>
please *please* *_please_*!!! don't do it! :)
Let the controller driver do it *only in case it's not working in PIO!*

Vitaly
