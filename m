Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVCNT3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVCNT3Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVCNT3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:29:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42147 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261750AbVCNT3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:29:22 -0500
Subject: Re: [PATCH] 2.6.11-mm3 patch for ext3 writeback "nobh" option
From: Arjan van de Ven <arjan@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
References: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 20:29:13 +0100
Message-Id: <1110828554.6288.109.camel@laptopd505.fenrus.org>
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

On Mon, 2005-03-14 at 11:18 -0800, Badari Pulavarty wrote:
> Hi Andrew,
> 
> Here is the 2.6.11-mm3 version of patch for adding "nobh"
> support for ext3 writeback mode.

can you explain why this is an option ? It's not like the on disk layout
changes or something... is there a reason to ever not want this?


