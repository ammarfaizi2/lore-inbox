Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUI1KcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUI1KcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUI1KcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:32:16 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:5299 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266175AbUI1KcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:32:11 -0400
Date: Tue, 28 Sep 2004 12:33:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Matt Heler <lkml@lpbproductions.com>
Subject: Re: 2.6.9-rc2-mm4
Message-ID: <20040928103324.GA21050@elte.hu>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409272142.35182.gene.heskett@verizon.net> <20040928070104.GA14836@elte.hu> <200409280626.50167.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409280626.50167.gene.heskett@verizon.net>
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


* Gene Heskett <gene.heskett@verizon.net> wrote:

> >what i use is serial logging to another machine. A digital camera is
> >fine too, if the problem area is still visible on the screen.
> >(Netconsole is useful too for other type of hangs but it's not
> > active at such an early stage yet.)
> >
> > Ingo
> 
> Unforch, I don't have a spare seriel port Ingo.  One is running my x10 

fortunately with the patch applied your box works now (so does mine) so
the bug appears to be fixed.

early-bootup debugging was never easy, and breakage there doesnt happen
all that often. Hopefully this was the last one related to remove-BKL. 

(If such a early-bootup lockup happens in the future then you sure could
temporarily unplug the ups serial connection and use that as the serial
console - for the narrow and temporary purpose of debugging that
boot-time hang.)

	Ingo
