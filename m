Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVDJRt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVDJRt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVDJRtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:49:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5605 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261535AbVDJRre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:47:34 -0400
Date: Sun, 10 Apr 2005 19:47:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
Message-ID: <20050410174723.GC18768@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu> <42596101.3010205@cybsft.com> <20050410172759.GA16654@elte.hu> <1113154793.20980.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113154793.20980.15.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Would there be any harm with changing that to 
> 
> #define jbd_debug(f, a...) do {} while(0)
> 
> The compiler would strip it anyway, and you wouldn't have to worry 
> about your scripts removing the macro.

yeah, that's what i did in -45-01. Since it's not the first time this 
has happened i might have to change the marker to /*I*/ or something 
like that :-)

	Ingo
