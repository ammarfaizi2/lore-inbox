Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVHaLvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVHaLvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVHaLvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:51:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10170 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932409AbVHaLvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:51:49 -0400
Subject: Re: [PATCH 1/1] Implement shared page tables
From: Arjan van de Ven <arjan@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.61.0508311143340.15467@goblin.wat.veritas.com>
References: <7C49DFF721CB4E671DB260F9@[10.1.1.4]>
	 <Pine.LNX.4.61.0508311143340.15467@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 13:51:17 +0200
Message-Id: <1125489077.3213.12.camel@laptopd505.fenrus.org>
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

On Wed, 2005-08-31 at 12:44 +0100, Hugh Dickins wrote:
> I was going to say, doesn't randomize_va_space take away the rest of
> the point?  But no, it appears "randomize_va_space", as it currently
> appears in mainline anyway, is somewhat an exaggeration: it just shifts
> the stack a little, with no effect on the rest of the va space.

it also randomizes mmaps


