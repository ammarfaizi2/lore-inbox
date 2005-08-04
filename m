Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVHDITm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVHDITm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 04:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVHDITm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 04:19:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64718 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262255AbVHDITk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 04:19:40 -0400
Subject: Re: [PATCH 2/3] cpqarray: ioctl support to configure LUNs
	dynamically
From: Arjan van de Ven <arjan@infradead.org>
To: "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>
Cc: axboe@suse.de, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4221C1B21C20854291E185D1243EA8F302623BD9@bgeexc04.asiapacific.cpqcorp.net>
References: <4221C1B21C20854291E185D1243EA8F302623BD9@bgeexc04.asiapacific.cpqcorp.net>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 10:18:43 +0200
Message-Id: <1123143523.3318.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 10:15 +0530, Saripalli, Venkata Ramanamurthy
(STSD) wrote:
> Patch 2 of 3
> This patch adds support for IDAREGNEWDISK, IDADEREGDISK, IDAGETLOGINFO
> ioctls required
> to configure LUNs dynamically on SA4200 controller using ACU.


I don't think it's a good idea to add new ioctls to drivers like this...


