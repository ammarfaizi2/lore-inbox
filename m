Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268831AbUHUDXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268831AbUHUDXY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 23:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268833AbUHUDXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 23:23:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24775 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268831AbUHUDXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 23:23:23 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040820133031.GA13105@elte.hu>
References: <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu>  <20040820133031.GA13105@elte.hu>
Content-Type: text/plain
Message-Id: <1093058602.854.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 23:23:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 09:30, Ingo Molnar wrote:

>  - reduce ZAP_BLOCK_SIZE to 16 when vp != 0. This pushes the exit
>    latency down to below 100 usecs on Lee Revell's box.
> 

Almost:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6#/var/www/2.6.8.1-P6/trace8.txt

Lee


