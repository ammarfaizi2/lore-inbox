Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVAMOHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVAMOHe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVAMOHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:07:34 -0500
Received: from canuck.infradead.org ([205.233.218.70]:1039 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261626AbVAMOHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:07:30 -0500
Subject: Re: propolice support for linux
From: Arjan van de Ven <arjan@infradead.org>
To: Han Boetes <han@mijncomputer.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050113134620.GA14127@boetes.org>
References: <20050113134620.GA14127@boetes.org>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 15:07:22 +0100
Message-Id: <1105625242.6031.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 14:45 +0059, Han Boetes wrote:

> And since most of the security-flaws in linux are buffer-overflows
> I would like to request that a patch based on this one is applied
> to the kernel so people can use this extension by default.
> 

I'm sorry but I disagree with this. Most of the security flaws in the
kernel are NOT buffer overflows. Almost none are! (and that is because
in the linux kernel you are very much stack constrained and can't put
large-ish buffers on the stack).

Userland.. that's a different matter.
Propolice is one of the options there, there are others too. But for the
kernel, buffer overflows are really rare (esp ones that propolice and
other tools can catch).


