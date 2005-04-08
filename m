Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVDHJXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVDHJXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 05:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVDHJXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 05:23:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21431 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262767AbVDHJXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 05:23:46 -0400
Subject: Re: Signing modules in Kernel 2.4
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050408103224.44ba104f.Christoph.Pleger@uni-dortmund.de>
References: <20050408103224.44ba104f.Christoph.Pleger@uni-dortmund.de>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 11:23:41 +0200
Message-Id: <1112952221.6278.26.camel@laptopd505.fenrus.org>
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

On Fri, 2005-04-08 at 10:32 +0200, Christoph Pleger wrote:
> Hello,
> 
> I found a patch for Kernels 2.6 that ensures kernel integrity by
> digitally signing kernel modules. Is something similar available for
> 2.4-Kernels?

2.4 kernels have a userspace insmod. so you would need to have a trusted
insmod too. Forget it, just go to 2.6


