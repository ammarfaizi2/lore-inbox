Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUC1JGE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 04:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUC1JGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 04:06:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6307 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262126AbUC1JGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 04:06:02 -0500
Date: Sun, 28 Mar 2004 11:06:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Glenn Johnson <glennpj@charter.net>
Cc: Andrew Morton <akpm@osdl.org>, Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm[34] causes drop in DRI FPS
Message-ID: <20040328090637.GA11056@elte.hu>
References: <1080435375.8280.1.camel@gforce.johnson.home> <20040327180932.10e4bae7.akpm@osdl.org> <1080443802.7085.2.camel@gforce.johnson.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080443802.7085.2.camel@gforce.johnson.home>
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


* Glenn Johnson <glennpj@charter.net> wrote:

> > It could be the AGP changes.  Please do a `patch -p1 -R' of
> > bk-agpgart.patch and retest?
> 
> I reverted that patch and retested but it did not solve the problem. I
> am still only seeing about 180 fps with glxgears.

what does 'glxinfo | grep rendering' show?

	Ingo
