Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274845AbTGaREZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274846AbTGaREY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:04:24 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:56487 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S274845AbTGaRET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:04:19 -0400
Message-ID: <3F294C31.6030702@softhome.net>
Date: Thu, 31 Jul 2003 19:04:49 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase
References: <eLiy.31J.3@gated-at.bofh.it> <eLBW.3eJ.7@gated-at.bofh.it> <eLVb.3yF.1@gated-at.bofh.it> <eOJn.5NI.1@gated-at.bofh.it> <f1dJ.GS.21@gated-at.bofh.it> <faTE.2LQ.3@gated-at.bofh.it> <fd56.4Te.9@gated-at.bofh.it> <fdRv.5uB.9@gated-at.bofh.it> <fnHd.54o.19@gated-at.bofh.it> <3F294461.2020902@softhome.net> <20030731164326.GG27214@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030731164326.GG27214@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> Shutdown != sleep.  If you want to wake devices up again, you need to do
> them in the right order.
> 

     You didn't get my point.
     My appliances do not need sleep/shutdown at all.
     Not every embedded system is a handheld ;-)

     Shutdown was smth like:
     # mount / -o ro; sync; lcd-off; \
	dd if=/dev/zero seek=0xBYE of=/dev/port
     For a long time it was shell script :-)))

