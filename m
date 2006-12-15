Return-Path: <linux-kernel-owner+w=401wt.eu-S1752763AbWLOPxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbWLOPxt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 10:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWLOPxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 10:53:49 -0500
Received: from mail2.utc.com ([192.249.46.191]:42747 "EHLO mail2.utc.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763AbWLOPxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 10:53:48 -0500
X-Greylist: delayed 710 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 10:53:48 EST
Message-ID: <4582C234.4040408@cybsft.com>
Date: Fri, 15 Dec 2006 09:41:40 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: linux@bohmer.net
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] 2.6.19-rt14 does not compile with CONFIG_NO_HZ
References: <3efb10970612150606p643f7cffr6b93e857843abed6@mail.gmail.com>
In-Reply-To: <3efb10970612150606p643f7cffr6b93e857843abed6@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remy Bohmer wrote:
> Hello,
> 
> For your Information, I get the following compile error when
> CONFIG_NO_HZ is NOT configured on 2.6.19.1-rt14:
> 
> ------------------------------------------------------
>   CC      kernel/sched.o
> kernel/sched.c: In function '__schedule':
> kernel/sched.c:4135: error: 'notick' undeclared (first use in this
> function)
> kernel/sched.c:4135: error: (Each undeclared identifier is reported only
> once
> kernel/sched.c:4135: error: for each function it appears in.)
> make[1]: *** [kernel/sched.o] Error 1
> ------------------------------------------------------
> 
> For me it is not a real problem as I configured the kernel now as a
> tickless system.
> Attached 2 config files, 1 showing the error, and 1 that is working.
> 
> Kind Regards,
> 
> Remy Bohmer

See Steven's patch to fix this here: >
http://marc.theaimsgroup.com/?l=linux-kernel&m=116611237701140&w=2



-- 
   kr
