Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVCVMhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVCVMhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVCVMhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:37:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25788 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261173AbVCVMh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:37:27 -0500
Subject: Re: Fusion-MPT much faster as module
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Holger Kiehl'" <Holger.Kiehl@dwd.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       "Moore, Eric  Dean" <emoore@lsil.com>
In-Reply-To: <20050322122801.GI3982@stusta.de>
References: <200503221029.j2MATNg12775@unix-os.sc.intel.com>
	 <1111488742.7096.61.camel@laptopd505.fenrus.org>
	 <20050322122801.GI3982@stusta.de>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 13:37:10 +0100
Message-Id: <1111495030.7096.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> And there are places where it's actually useful:
> 
>   #if defined(CONFIG_FOO) || (defined(MODULE) && defined(CONFIG_FOO_MODULE))
> 
> is a good way to express that driver bar can use functionality of driver 
> foo if it's available.

a good way? I'd disagree with that :)


