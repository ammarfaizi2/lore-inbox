Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbUCPIaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263536AbUCPIaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:30:12 -0500
Received: from [157.181.151.9] ([157.181.151.9]:1765 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263548AbUCPIaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:30:10 -0500
Date: Tue, 16 Mar 2004 08:24:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 - 4g patch breaks when X86_4G not selected
Message-ID: <20040316072442.GB2705@elte.hu>
References: <20040310233140.3ce99610.akpm@osdl.org> <16465.3163.999977.302378@notabene.cse.unsw.edu.au> <20040311172244.3ae0587f.akpm@osdl.org> <16465.20264.563965.518274@notabene.cse.unsw.edu.au> <20040311235009.212d69f2.akpm@osdl.org> <16466.57738.590102.717396@notabene.cse.unsw.edu.au> <16469.2797.130561.885788@notabene.cse.unsw.edu.au> <20040315091843.GA21587@elte.hu> <16470.22982.831048.924954@notabene.cse.unsw.edu.au> <20040315205201.7699e1c1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315205201.7699e1c1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another thing: the bzImage is pretty large (1.7MB) - maybe 4G just
pushes the size of the kernel past some size limit. Same for SLAB_DEBUG.

	Ingo
