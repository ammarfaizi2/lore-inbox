Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbUKHS2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUKHS2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUKHS1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:27:38 -0500
Received: from canuck.infradead.org ([205.233.218.70]:39942 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261156AbUKHSZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:25:11 -0500
Subject: Re: RFC: [2.6 patch] small IPMI cleanup
From: Arjan van de Ven <arjan@infradead.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <418FB0EA.90006@mvista.com>
References: <20041106222839.GS1295@stusta.de>  <418FB0EA.90006@mvista.com>
Content-Type: text/plain
Message-Id: <1099938282.3577.21.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 08 Nov 2004 19:24:43 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 11:46 -0600, Corey Minyard wrote:
> Adrian,
> 
> All these things are tools used by external modules that have not yet 
> made it into the mainstream kernel.

is there an ETA for those to go in ?

>   Also, there are other users of 
> these functions that are perhaps not in the kernel yet (and perhaps 
> never make it into the mainstream kernel).

well... is it really worth it to bloat all the kernels out there for
some obscure thing that apparently isn't useful enough to be in the main
kernel or even to be submitted for it...
Sounds rather like it's better to remove those from the kernel, or at least #if 0 them if you really really insist.

