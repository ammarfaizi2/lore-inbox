Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVF1Hgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVF1Hgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVF1Hdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:33:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26338 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261504AbVF1HaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:30:19 -0400
Date: Tue, 28 Jun 2005 09:30:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2
Message-ID: <20050628073006.GA7368@elte.hu>
References: <fa.h6rvsi4.j68fhk@ifi.uio.no> <42BFA05B.1090208@reub.net> <20050627002429.40231fdf.akpm@osdl.org> <42BFAF1F.8050201@reub.net> <20050627012226.450bc86d.akpm@osdl.org> <20050627093708.GA23150@elte.hu> <20050627141439.4b3cb641.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627141439.4b3cb641.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > is the fput()/sysfs_release() crash below known?
> 
> It doesn't ring any bells.
> 
> You have a use-after-free error when udev is dinking with a sysfs 
> file.  It could be anything.  Could you debug it a bit, please, work 
> out which file caused the crash?

unfortunately it's totally unreproducible, it triggered only once during 
hundreds of bootups. Will keep eyes open though.

	Ingo
