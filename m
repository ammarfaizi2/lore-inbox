Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVLEOEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVLEOEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVLEOEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:04:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52434 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751217AbVLEOEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:04:06 -0500
Subject: Re: Kernel BUG at page_alloc.c:117!
From: Arjan van de Ven <arjan@infradead.org>
To: zine el abidine Hamid <zine46@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051205135723.83840.qmail@web30602.mail.mud.yahoo.com>
References: <20051205135723.83840.qmail@web30602.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 15:04:03 +0100
Message-Id: <1133791443.9356.23.camel@laptopd505.fenrus.org>
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

On Mon, 2005-12-05 at 14:57 +0100, zine el abidine Hamid wrote:
> Hello Dirk,
>  
>  First, thank you for responding so fast.
>  I have to use the kernel 2.4.18 (or at best the
> 2.4.22). 

why?

>  I want first understand what's appened; 

something in the kernel did something wrong, which caused the VM to
notice the corruption

> Is-it a
> kernel
>  problem or is-it a bug off our application which is
> written in C++.

it's probably a driver bug (at least that's most common)
>  It seems like there a bug with the VM; is it true?

no it's something that went wrong and first got noticed in the VM,
that's different from being a bug in the VM.


which exactly modules were in use? Are there any modules that didn't
come with that kernel? 

