Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVCGXAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVCGXAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVCGXA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:00:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36796 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261798AbVCGWWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:22:24 -0500
Subject: Re: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new
	module  for LSI Logic's SAS based MegaRAID controllers
From: Arjan van de Ven <arjan@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CC0E@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230CC0E@exa-atlanta>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 23:22:15 +0100
Message-Id: <1110234135.9233.73.camel@laptopd505.fenrus.org>
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

On Mon, 2005-03-07 at 16:12 -0500, Bagalkote, Sreenivas wrote:

> +static	int				is_dma64;

the fact that this is a global variable worries me.



