Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVF1TAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVF1TAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVF1S5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:57:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19903 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261201AbVF1S4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:56:23 -0400
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
In-Reply-To: <Pine.LNX.4.62.0506281141050.959@graphe.net>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 20:56:15 +0200
Message-Id: <1119984975.3175.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Tue, 2005-06-28 at 11:47 -0700, Christoph Lameter wrote:
> Place x86_64 and i386 syscall table into the read only section.
> 
> Remove the syscall tables from the data section and place them into the 
> readonly section (like IA64).

I like it.. however I think the 32 bit compat syscall table on x86-64
deserves the same treatment....


