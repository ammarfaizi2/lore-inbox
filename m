Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUJITY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUJITY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 15:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUJITY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 15:24:59 -0400
Received: from gonzo.webpack.hosteurope.de ([217.115.142.69]:12466 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S267312AbUJITY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 15:24:57 -0400
Date: Sat, 9 Oct 2004 21:26:14 +0000
From: stefan.eletzhofer@eletztrick.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041009212614.GA25441@tier.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <41677E4D.1030403@mvista.com> <416822B7.5050206@opersys.com> <1097346628.1428.11.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097346628.1428.11.camel@krustophenia.net>
Organization: Eletztrick Computing
User-Agent: Mutt/1.5.6i
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 02:30:28PM -0400, Lee Revell wrote:
> On Sat, 2004-10-09 at 13:41, Karim Yaghmour wrote:
> > Sven-Thorsten Dietrich wrote:
> > >     - Voluntary Preemption by Ingo Molnar
> > >     - IRQ thread patches by Scott Wood and Ingo Molnar
> > >     - BKL mutex patch by Ingo Molnar (with MV extensions)
> > >     - PMutex from Germany's Universitaet der Bundeswehr, Munich
> > >     - MontaVista mutex abstraction layer replacing spinlocks with mutexes
> > 
> > To the best of my understanding, this still doesn't provide deterministic
> > hard-real-time performance in Linux.
> 
> Using only the VP+IRQ thread patch, I ran my RT app for 11 million
> cycles yesterday, with a maximum delay of 190 usecs.  How would this not
> satisfy a 200 usec hard RT constraint?

I think the keyword here is "deterministic", isn't it?

> 
> PHB:      "I've looked at your proposal and decided it can't be done"
> Dilbert:  "I just did it.  It's working perfectly" 
> 
> Lee
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Stefan Eletzhofer
InQuant Data GBR
http://www.inquant.de
+49 (0) 751 35 44 112 
+49 (0) 171 23 24 529 (Mobil)
+49 (0) 751 35 44 115 (FAX)
