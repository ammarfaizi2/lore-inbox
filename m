Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWGYPKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWGYPKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGYPKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:10:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57262 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932410AbWGYPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:10:52 -0400
Subject: Re: [PATCH 1/3] scsi : megaraid_{mm,mbox}: 64-bit DMA capability
	checker
From: Arjan van de Ven <arjan@infradead.org>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: vvs@sw.ru, James.Bottomley@SteelEye.com, akpm@osdl.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
In-Reply-To: <890BF3111FB9484E9526987D912B261932E2CF@NAMAIL3.ad.lsil.com>
References: <890BF3111FB9484E9526987D912B261932E2CF@NAMAIL3.ad.lsil.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 17:10:42 +0200
Message-Id: <1153840242.8932.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +1.	Fixed a bug in megaraid_init_mbox().
> +	Customer reported "garbage in file on x86_64 platform".
> +	Root Cause: the driver registered controllers as 64-bit DMA
> capable
> +	for those which are not support it.
> +	Fix: Made change in the function inserting identification
> machanism
> +	identifying 64-bit DMA capable controllers.
> +

Hi,

unfortunately your patch has been corrupted by your email program,
and as such can't be applied by the scsi maintainer. It might be 
a good idea to fix your email program and then resend quickly before 
James notices ;)

Greetings,
   Arjan van de Ven

