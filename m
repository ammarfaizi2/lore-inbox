Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVDFMwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVDFMwZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVDFMwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:52:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38798 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262146AbVDFMwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:52:21 -0400
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20050406123147.GD9417@suse.de>
References: <20050329122226.94666.qmail@web52902.mail.yahoo.com>
	 <20050329122635.GP16636@suse.de>  <20050406123147.GD9417@suse.de>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 14:52:10 +0200
Message-Id: <1112791930.6275.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

> @@ -324,6 +334,7 @@
>  	issue_flush_fn		*issue_flush_fn;
>  	prepare_flush_fn	*prepare_flush_fn;
>  	end_flush_fn		*end_flush_fn;
> +	release_queue_data_fn	*release_queue_data_fn;
>  
>  	/*
>  	 * Auto-unplugging state

where does this function method actually get called?

