Return-Path: <linux-kernel-owner+w=401wt.eu-S1751391AbXANRhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXANRhZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 12:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXANRhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 12:37:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55151 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXANRhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 12:37:24 -0500
Subject: Re: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with
	macros
From: Arjan van de Ven <arjan@infradead.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <20070114172421.GA3874@Ahmed>
References: <20070114172421.GA3874@Ahmed>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 14 Jan 2007 09:37:21 -0800
Message-Id: <1168796241.3123.954.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 19:24 +0200, Ahmed S. Darwish wrote:
> Substitue intel_rng magic PCI IDs values used in the IDs table
> with the macros defined in pci_ids.h
> 
Hi,


hmm this is actually the opposite direction than most of the kernel is
heading in, mostly because the pci_ids.h file is a major maintenance
pain.

Afaik the current "rule" is: if a PCI ID is only used in one driver, use
the numeric value and not (add) a symbolic constant.


Greetings,
   Arjan van de Ven

