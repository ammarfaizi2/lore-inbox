Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318959AbSICWdU>; Tue, 3 Sep 2002 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318962AbSICWdU>; Tue, 3 Sep 2002 18:33:20 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:24962 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318959AbSICWdU>; Tue, 3 Sep 2002 18:33:20 -0400
Date: Tue, 3 Sep 2002 16:37:48 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Remco Post <r.post@sara.nl>
cc: Oliver Pitzeier <o.pitzeier@uptime.at>, <thunder@lightweight.ods.org>,
       <donaldlf@cs.rose-hulman.edu>, <axp-kernel-list@redhat.com>,
       <linux-kernel@vger.kernel.org>, <ink@jurassic.park.msu.ru>
Subject: Re: [PATCH] include/linux/ptrace.h Re: Kernel 2.5.33 compile errors
 (Re: Kernel 2.5.33 successfully compiled)
In-Reply-To: <20020904002243.7d3a4412.r.post@sara.nl>
Message-ID: <Pine.LNX.4.44.0209031635160.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Sep 2002, Remco Post wrote:
> Attached patch worked for _compiling_ on my powermac, it might help for
> you as well....

I'd rather not include sched.h into ptrace.h, for that way lies madness. 
You get all the crappy headers when you only include one of them. I'm not 
saying the change itself is wrong. It's indeed effective. But it's that 
cleanup vs. messup thing.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

