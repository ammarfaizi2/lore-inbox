Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbUJ0TcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUJ0TcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUJ0TWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:22:08 -0400
Received: from web12206.mail.yahoo.com ([216.136.173.90]:38920 "HELO
	web12206.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262654AbUJ0S7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:59:46 -0400
Message-ID: <20041027185934.18230.qmail@web12206.mail.yahoo.com>
Date: Wed, 27 Oct 2004 20:59:34 +0200 (CEST)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
To: Rui Nuno Capela <rncbc@rncbc.org>, Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
In-Reply-To: <32865.192.168.1.5.1098898770.squirrel@192.168.1.5>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Rui Nuno Capela <rncbc@rncbc.org> schrieb: 
> Should I try the other way around? Lets see... 'chrt -p
> -f 90 `pidof
> ksoftirwd/0`',... yes, apparentely the xrun rate seems to
> decrease into
> half, but IMHO not conclusive enough, thought.
> 
'into half' makes me wonder:
did you also 'chrt -p -f 90 `pidof ksoftirwd/1`'?
(I guess you meant that with '...') And isn't it
'ksoftirqd'? Just in case :-)

Best,
Karsten


	

	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
