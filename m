Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267774AbUHFIjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267774AbUHFIjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUHFIiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:38:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36571 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268107AbUHFIfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:35:11 -0400
Date: Fri, 6 Aug 2004 10:36:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@aracnet.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] schedstats and staircase scheduler
Message-ID: <20040806083622.GC8279@elte.hu>
References: <200408060816.i768FxL06596@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408060816.i768FxL06596@owlet.beaverton.ibm.com>
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


* Rick Lindsley <ricklind@us.ibm.com> wrote:

> Content-Description: rc3-mm1x.100-sstat-nosmp
> SMP fix --
>     for_each_domain() is not defined if not CONFIG_SMP, so show_schedstat
>     needed a couple of extra ifdefs.

looks good to me.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
