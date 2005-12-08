Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVLHOOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVLHOOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVLHOOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:14:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21163 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932134AbVLHOOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:14:35 -0500
Subject: Re: How to enable/disable security features on mmap() ?
From: Arjan van de Ven <arjan@infradead.org>
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43983EBE.2080604@labri.fr>
References: <43983EBE.2080604@labri.fr>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 15:14:32 +0100
Message-Id: <1134051272.2867.63.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 15:10 +0100, Emmanuel Fleury wrote:
> Hi,
> 
> For educational purpose (I'm teaching software security) I would like to
> be able to compile several kernels with or without features such as:
> 
> * Non-executable stack
> * Stack address randomization
> * Environment address randomization (char **envp)
> * Dynamic library randomization (cat /proc/self/map)
> 
> So, is there a way to do such thing easily, or should I write patches by
> myself ?

realistically the first one is easy if your hw supports the NX bit
(x86/x86-64). Some of the other randomisations are present in the 2.6.x
kernels.

Or run a kernel from Fedora Core, or a kernel with the PaX patches to
get all you're asking for.


