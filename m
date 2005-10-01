Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVJAPPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVJAPPp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 11:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVJAPPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 11:15:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40419 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750735AbVJAPPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 11:15:44 -0400
Subject: Re: [PATCH] missing ifdef in mod_devicetable.h for 2.6.14-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <873bnlb7oh.fsf@sycorax.lbl.gov>
References: <873bnlb7oh.fsf@sycorax.lbl.gov>
Content-Type: text/plain
Date: Sat, 01 Oct 2005 17:15:36 +0200
Message-Id: <1128179737.2916.6.camel@laptopd505.fenrus.org>
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

On Sat, 2005-10-01 at 08:03 -0700, Alex Romosan wrote:
> this was introduced in rc1 and is still present in rc3. without the
> patch below i can't compile alsa cvs.


while our patch isn't wrong... makes me wonder if alsa cvs has a bug in
their makefiles ...

