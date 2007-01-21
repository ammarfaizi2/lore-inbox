Return-Path: <linux-kernel-owner+w=401wt.eu-S1751305AbXAUJNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbXAUJNX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 04:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbXAUJNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 04:13:22 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:15164 "EHLO
	amsfep18-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751305AbXAUJNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 04:13:22 -0500
Subject: Re: Realtime-preemption for 2.6.20-rc5 ?
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Sunil Naidu <akula2.shark@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200701210039.27284.pisa@cmp.felk.cvut.cz>
References: <200701210039.27284.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain
Date: Sun, 21 Jan 2007 10:10:38 +0100
Message-Id: <1169370638.6197.175.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-21 at 00:39 +0100, Pavel Pisa wrote:
> Hello Sunil and Ingo,
> 
> Date: 2007-01-20 02:56:40 GMT (20 hours and 26 minutes ago)
> > 2007-01-20, Sunil Naidu <akula2.shark@gmail.com> wrote:
> > I did refer the same. Is it necessary to use only base kernel, say
> > 2.6.19? Or, can I go ahead with 2.6.19 + 2.6.19.2 patch + 2.6.19-rt
> > patch?
> >
> > If yes, any reason why we need to apply rt patch only to a base kernel?
> 
> according to my observation 2.6.19-rt15 is based/includes 2.6.19.1 changes.
> 
> But there has been that nasty clear_page_dirty_for_io() bug causing
> corruption of ext3. Even that I have tested more 2.6.20-rc + rt, 

> I preffer
> to stay on "stable" kernel on boxes which I use daily until next stable
> appears.

This is a very weird statement, the -rt kernel includes so much
experimental work it cannot be called 'stable' by a long shot.

Sure its not known unstable, but neither is .20-rc5.

If you want -rt, just run with the latest unless you have a very
specific need not to.

