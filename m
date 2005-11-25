Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbVKYPEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbVKYPEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbVKYPEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:04:21 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:43937 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161102AbVKYPET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:04:19 -0500
Date: Fri, 25 Nov 2005 16:03:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, paulmck@us.ibm.com,
       Roland McGrath <roland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: Thread group exec race -> null pointer... HELP
Message-ID: <20051125150348.GA14919@elte.hu>
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com> <436E1401.920A83EE@tv-sign.ru> <437BC01D.60302@mvista.com> <43826FDC.8010401@mvista.com> <43832F1D.F56D1C00@tv-sign.ru> <4384D17C.4040902@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384D17C.4040902@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> >This patch:
> >
> >	http://marc.theaimsgroup.com/?l=linux-kernel&m=113138286512847
> >
> >was intended to fix exactly this problem (and the same test program was
> >used to exploit the race and test the fix).
> >
> >So, it does not help? I can't reproduce the problem.
> 
> Yes, it does fix it.  Somehow I missed the posting of that patch.

fyi, i've included the patch in -rt15.

	Ingo
