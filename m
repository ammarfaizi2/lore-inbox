Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUHQRyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUHQRyN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 13:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUHQRyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 13:54:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7103 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266543AbUHQRyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 13:54:12 -0400
Date: Tue, 17 Aug 2004 19:55:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paulo Marques <pmarques@grupopie.com>, Keith Owens <kaos@ocs.com.au>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040817175511.GA29763@elte.hu>
References: <6450.1092747900@ocs3.ocs.com.au> <41220FEA.9050106@grupopie.com> <20040817162323.GA7689@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817162323.GA7689@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sam Ravnborg <sam@ravnborg.org> wrote:

> That said do not put too much effort moving kode from the kernel to
> kallsyms.c. kallsyms support can be deselected, and users will not
> care about the little extra overhead (down in noise compared with the
> symbols).

distributions tend to enable it though, so saving 64K of kernel RAM is 
good indeed. Good compression of the symbols increases the applicability 
of kallsyms.

	Ingo
