Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVLTSKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVLTSKD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLTSKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:10:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32435 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750823AbVLTSKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:10:00 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: David Lang <dlang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0512200951080.11093@qynat.qvtvafvgr.pbz>
References: <200512201428.jBKESAJ5004673@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.62.0512200951080.11093@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 19:09:57 +0100
Message-Id: <1135102197.2952.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> how many other corner cases are there that these distros just choose not 
> to support, but need to be supported and tested for the vanilla kernel?

as someone who was at that distro in the time.. none other than XFS and
reiserfs4.

> also for those who are arguing that it's only dropping from 6k to 4k, you 
> are forgetting that the patches to move the interrupts to a seperate stack 
> have already gone into the kernel, so today it is really 8k+4k and the 
> talk is to move it to 4k+4k.

actually irq stacks aren't enabled with 8K stacks right now, so your
statement isn't correct.


