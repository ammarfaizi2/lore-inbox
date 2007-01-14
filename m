Return-Path: <linux-kernel-owner+w=401wt.eu-S1751250AbXANMNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbXANMNt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 07:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXANMNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 07:13:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36618 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbXANMNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 07:13:48 -0500
Date: Sun, 14 Jan 2007 13:09:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Damien Wyart <damien.wyart@free.fr>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc5: known unfixed regressions
Message-ID: <20070114120916.GA30798@elte.hu>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org> <20070113071125.GG7469@stusta.de> <87bql2ylfb.fsf@brouette.noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bql2ylfb.fsf@brouette.noos.fr>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Damien Wyart <damien.wyart@free.fr> wrote:

> > Subject    : BUG: scheduling while atomic: hald-addon-stor/...
> >              cdrom_{open,release,ioctl} in trace
> > References : http://lkml.org/lkml/2006/12/26/105
> >              http://lkml.org/lkml/2006/12/29/22
> >              http://lkml.org/lkml/2006/12/31/133
> > Submitter  : Jon Smirl <jonsmirl@gmail.com>
> >              Damien Wyart <damien.wyart@free.fr>
> >              Aaron Sethman <androsyn@ratbox.org>
> > Status     : unknown
> 
> I have not seen the problem since using rc3, so I guess it is ok now. 
> Maybe the commit 9414232fa0cc28e2f51b8c76d260f2748f7953fc has fixed 
> the problem, but I am not 100% sure.

yes, that commit should have fixed it.

	Ingo
