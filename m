Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUELTfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUELTfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUELTf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:35:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48096 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265193AbUELTet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:34:49 -0400
Date: Wed, 12 May 2004 21:33:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512193349.GA14936@elte.hu>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A26FFA.4030701@pobox.com>
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


* Jeff Garzik <jgarzik@pobox.com> wrote:

> >Woah, that's new.  And wrong.  The code in include/asm-i386/param.h that
> >says:
> >	# define JIFFIES_TO_MSEC(x)     (x)
> >	# define MSEC_TO_JIFFIES(x)     (x)
> >
> >Is not correct.  Look at kernel/sched.c for verification of this :)
> 
> 
> Yes, that is _massively_ broken.

why is it wrong?

	Ingo
