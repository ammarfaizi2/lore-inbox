Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbUK0Gop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUK0Gop (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUKZTLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:11:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:32190 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261282AbUKZTHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:07:14 -0500
Message-ID: <57563.195.245.190.93.1101381289.squirrel@195.245.190.93>
In-Reply-To: <20041125120133.GA22431@elte.hu>
References: <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
    <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
    <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
    <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
    <20041124112745.GA3294@elte.hu>
    <21889.195.245.190.93.1101377024.squirrel@195.245.190.93>
    <20041125120133.GA22431@elte.hu>
Date: Thu, 25 Nov 2004 11:14:49 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-0
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 25 Nov 2004 11:15:54.0835 (UTC) FILETIME=[216A7A30:01C4D2E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>
> the -RT patchset doesnt properly detect my fd0 device, so there's
> definitely something broken in that area. The unpatched -rc2-mm3 kernel
> detects it fine. Might be an effect of IRQ threading - the floppy
> hardware/driver is a fragile beast.
>

But it works flawlessly on my laptop (P4/UP). Could it be SMP/HT related?

-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

