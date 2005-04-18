Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVDRPoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVDRPoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVDRPoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:44:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12759 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262023AbVDRPoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:44:04 -0400
Subject: Re: [RFC 1 of 9] patches to add diskdump functionality to block
	layer
From: Arjan van de Ven <arjan@infradead.org>
To: mike.miller@hp.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       marcelo.tosatti@cyclades.com
In-Reply-To: <20050418153644.GA25409@beardog.cca.cpqcorp.net>
References: <20050418153644.GA25409@beardog.cca.cpqcorp.net>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 17:43:55 +0200
Message-Id: <1113839036.6274.78.camel@laptopd505.fenrus.org>
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

On Mon, 2005-04-18 at 10:36 -0500, mike.miller@hp.com wrote:
> Please review the following patches and provide any comments or feedback.
> Patch 1 of 9

what diskdump do you use?
Why do we even look at disk dump when kexec based dump can dump to disk
too and is otherwise more flexible and superior?

Maybe it's worth discussion that before doing major patches for.. well
potentially no good.


