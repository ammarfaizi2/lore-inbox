Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVKKFSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVKKFSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 00:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVKKFSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 00:18:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13486 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932360AbVKKFSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 00:18:48 -0500
Subject: Re: [RFC] sys_punchhole()
From: Arjan van de Ven <arjan@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, andrea@suse.de, hugh@veritas.com,
       lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <1131664994.25354.36.camel@localhost.localdomain>
References: <1131664994.25354.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 06:18:33 +0100
Message-Id: <1131686314.2833.0.camel@laptopd505.fenrus.org>
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

On Thu, 2005-11-10 at 15:23 -0800, Badari Pulavarty wrote:
> 
> We discussed this in madvise(REMOVE) thread - to add support 
> for sys_punchhole(fd, offset, len) to complete the functionality
> (in the future).

in the past always this was said to be "really hard" in linux locking
wise, esp. the locking with respect to truncate...

did you find a solution to this problem ?
> 

