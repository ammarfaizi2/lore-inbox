Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbVCXP6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbVCXP6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVCXP6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:58:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64970 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262847AbVCXP6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:58:11 -0500
Subject: Re: [PATCH 2.6.11] aoe [5/12]: don't try to free null bufpool
From: Arjan van de Ven <arjan@infradead.org>
To: ecashin@noserose.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1111677437.28285@geode.he.net>
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
	 <1111677437.28285@geode.he.net>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 16:58:04 +0100
Message-Id: <1111679884.6290.93.camel@laptopd505.fenrus.org>
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

On Thu, 2005-03-24 at 07:17 -0800, ecashin@noserose.net wrote:
> don't try to free null bufpool

in linux there is a "rule" that all memory free routines are supposed to
also accept NULL as argument, so I think this patch is not needed (and
even wrong)

