Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVCJNRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVCJNRY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 08:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVCJNRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 08:17:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23705 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262577AbVCJNRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 08:17:22 -0500
Subject: Re: BUG: using smp_processor_id() in preemptible [00000001] code:
	hotplug/461
From: Arjan van de Ven <arjan@infradead.org>
To: Knut J Bjuland <knutjbj@online.no>
Cc: rml@tech9.net, kpreempt-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <423043BE.2040105@online.no>
References: <423043BE.2040105@online.no>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 14:17:13 +0100
Message-Id: <1110460634.6291.86.camel@laptopd505.fenrus.org>
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

On Thu, 2005-03-10 at 13:55 +0100, Knut J Bjuland wrote:
>  caller is arch_add_exec_range+0x49/0x6a
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding: 7bit
> 
> When booting linux 2.6.11 with preemetable enable I get BUG: using 
> smp_processor_id() in preemptible [00000001] code: hotplug/461caller is 
> arch_add_exec_range+0x49/0x6a
> when I load the kernel. I get this error messeage before loading xorg 
> ,and the kernel is untained.


that function isn't in kernel.org kernels... but only in the Exec Shield
patch series.. sounds like you have a misapplied patch somewhere...


