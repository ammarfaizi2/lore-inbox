Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVJOJQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVJOJQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 05:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVJOJQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 05:16:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56494 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750994AbVJOJQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 05:16:08 -0400
Subject: Re: exec-shield integration into 2.6
From: Arjan van de Ven <arjan@infradead.org>
To: Michael Meyer <mike65134@yahoo.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051015085449.84412.qmail@web26810.mail.ukl.yahoo.com>
References: <20051015085449.84412.qmail@web26810.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Sat, 15 Oct 2005 11:15:58 +0200
Message-Id: <1129367759.2908.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
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

On Sat, 2005-10-15 at 10:54 +0200, Michael Meyer wrote:
> Hi,
> 
> I have read somewhere that there are some portions 
> of the exec-shield patches incoporated into the
> kernel.
> To what extend? 

The 32 bit NX support and parts of the randomisation are incorporated
already. The segment limit hack will never be incorporated (but that's
ok; NX is the real solution and more and more systems out there support
NX). The userspace parts of Exec-Shield are in the respective
gcc/glibc/binutils upstream codebases already.

> There are no exec-shield patches
> published for 2.6.13.x yet. Is this because the
> complete
> exec-shield patches have already been incorporated?

no more because you didn't look deep enough; they exist.
The most current patch is always in the rawhide kernel rpm; once in a
while that gets put into a "released" patch, but the rawhide one is
updated daily or just about.


