Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVGPRP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVGPRP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 13:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVGPRP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 13:15:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8094 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261474AbVGPRP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 13:15:56 -0400
Date: Sat, 16 Jul 2005 19:15:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: "K.R. Foley" <kr@cybsft.com>, Chuck Harding <charding@llnl.gov>,
       William Weston <weston@sysex.net>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050716171537.GB16235@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050713103930.GA16776@elte.hu> <42D51EAF.2070603@cybsft.com> <200507141450.42837.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507141450.42837.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Have I corrected the other path of ioapic early initialization, which 
> had lacked virtual-address setup before ioapic_data[ioapic] was to be 
> filled in -51-28? Please test attached patch on top of -51-29 or 
> later. Also on Systems that liked -51-28.

thanks - i've applied it to my tree and have released the -51-31 patch.  
It looks good on my testboxes.

	Ingo
