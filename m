Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267617AbUGWKnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267617AbUGWKnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 06:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUGWKnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 06:43:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33960 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267617AbUGWKnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 06:43:51 -0400
Date: Fri, 23 Jul 2004 12:42:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Rudo Thomas <rudo@matfyz.cz>, Matt Heler <lkml@lpbproductions.com>
Subject: [patch] voluntary-preempt-2.6.8-rc2-I3
Message-ID: <20040723104246.GA2752@elte.hu>
References: <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz> <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu> <20040722181426.GA892@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722181426.GA892@elte.hu>
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


i've uploaded the -I3 voluntary-preempt patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I3

it mainly fixes an ext3 livelock that could result in long delays during
heavy commit traffic.

	Ingo

