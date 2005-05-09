Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263067AbVEIHYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbVEIHYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 03:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVEIHYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 03:24:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15527 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263067AbVEIHYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 03:24:03 -0400
Date: Mon, 9 May 2005 09:23:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
Message-ID: <20050509072350.GA11976@elte.hu>
References: <20050422154931.GA22534@elte.hu> <Pine.LNX.4.44.0504220852310.22042-100000@dhcp153.mvista.com> <20050422155549.GB22795@elte.hu> <1114537755.12772.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114537755.12772.26.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> On Fri, 2005-04-22 at 08:55, Ingo Molnar wrote:
> 
> > i used:
> > 
> >   ./test --tasks 10 file.hist
> 
> This patch cleanup the delays on increased numbers of tasks. It goes 
> on to of the current plist snapshot.

ok, these fixes for priority init appear to have solved the pi-test 
latencies. I've uploaded the -rc4-RT-V0.7.47-00 patch with the plist 
code re-added again. It's looking good so far on my testboxes.

	Ingo
