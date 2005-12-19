Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVLSPuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVLSPuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVLSPuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:50:22 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:38628 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S964781AbVLSPuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:50:21 -0500
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI:  async message
	handing library update
From: dmitry pervushin <dpervushin@gmail.com>
To: David Brownell <david-b@pacbell.net>
Cc: Vitaly Wool <vwool@ru.mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
In-Reply-To: <200512181059.14301.david-b@pacbell.net>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com>
	 <20051213170629.7240d211.vwool@ru.mvista.com>
	 <20051215151948.497d703b.vwool@ru.mvista.com>
	 <200512181059.14301.david-b@pacbell.net>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 18:40:27 +0300
Message-Id: <1135006827.5451.5.camel@fj-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 10:59 -0800, David Brownell wrote:
>                         chipselect = !t->cs_change;
>                         if (chipselect);
>                                 continue;
> 
>                         bitbang->chipselect(spi, 0);
> 
>                         /* REVISIT do we want the udelay here instead?
> */
>                         msleep(1);
Ohhh. Have you intentionally put the semicolon after "if
(chipselect)" ? 

