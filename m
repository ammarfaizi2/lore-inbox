Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVA1EgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVA1EgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 23:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVA1EgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 23:36:13 -0500
Received: from mx1.elte.hu ([157.181.1.137]:64452 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261445AbVA1EgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 23:36:10 -0500
Date: Fri, 28 Jan 2005 05:35:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] to fix xtime lock for in the RT kernel patch
Message-ID: <20050128043537.GC29751@elte.hu>
References: <41F04573.7070508@mvista.com> <20050121063519.GA19954@elte.hu> <41F0BA56.9000605@mvista.com> <20050121082125.GA28267@elte.hu> <41F0BFA4.5030107@mvista.com> <20050121084557.GA29550@elte.hu> <41F0C33D.60908@mvista.com> <20050121090014.GA30379@elte.hu> <41F0C686.5070903@mvista.com> <41F954CE.6040504@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F954CE.6040504@mvista.com>
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


* George Anzinger <george@mvista.com> wrote:

> Ingo, I have been looking at the code being proposed by John Stultz. 
> It looks like it handles all the issues I am talking about here.  I
> think it would be best to leave the RT patch as it is WRT this issue
> and work on getting John's patch ready for prime time as any work I
> would do here will just get tossed when his patch hits the steet.
> 
> Meanwhile, I will (already have) get HRT working on RT and make that
> available in the next few days.

sure, fine with me. You might want to sync up with Thomas Gleixner,
who's working on some of the HRT issues too.

	Ingo
