Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVDBUnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVDBUnc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVDBUnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:43:32 -0500
Received: from mx1.elte.hu ([157.181.1.137]:39837 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261264AbVDBUnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:43:31 -0500
Date: Sat, 2 Apr 2005 22:34:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Message-ID: <20050402203458.GA16230@elte.hu>
References: <20050325145908.GA7146@elte.hu> <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com> <200504011834.22600.gene.heskett@verizon.net> <20050402051254.GA23786@elte.hu> <1112470675.27149.14.camel@localhost.localdomain> <1112472372.27149.23.camel@localhost.localdomain> <1112473038.28826.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112473038.28826.25.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> It wasn't clear from your last mail whether you were using NFS.  If so 
> I would be suspicious given the NFS changes in the new RT patches.  
> I'll try to reproduce the problem on a local fs.

also, try to undo the fs/nfs/*.c and include/linux/*nfs*.h changes, 
those are latency breakers, so not strictly necessary.

	Ingo
