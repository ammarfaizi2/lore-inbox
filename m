Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270097AbTHGPjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270346AbTHGPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:39:39 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:61093 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270097AbTHGPin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:38:43 -0400
Date: Thu, 7 Aug 2003 17:38:53 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Kathy Frazier <kfrazier@mdc-dayton.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [APM]  CPU idle calls causing problem with ASUS P4PE MoBo
Message-ID: <20030807153853.GA7030@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Kathy Frazier <kfrazier@mdc-dayton.com>,
	linux-kernel@vger.kernel.org
References: <PMEMILJKPKGMMELCJCIGIEPOCDAA.kfrazier@mdc-dayton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <PMEMILJKPKGMMELCJCIGIEPOCDAA.kfrazier@mdc-dayton.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kathy!

On Thu, Aug 07, 2003 at 11:08:09AM -0500, Kathy Frazier wrote:
[some important info zapped]
> When I changed the CONFIG_APM_CPU_IDLE to no, our 3 hour test 
> runs to completion.  Previously this test would cause the system 
> to hang within minutes.  

[some more important info zapped]
> I noticed that this version of linux does not have this particular ASUS MoBo
> in it's APM blacklist.  Has anyone seen similar symptoms with other MoBos
> which have crippled CPU idle BIOSs?  I would be happy to provide any
> additional testing needed to determine if this is a true APM/motherboard
> interaction related problem.
> 
> Thanks in advance!  Please cc me in your response.

lets assume that the APM/BIOS/idle stuff is broken
(which, as a matter of fact, is possible and very likely)
and this is the cause for the missing interrupts your
hardware sends, but the kernel never receives, wouldn't
this cause the same issues (missing interrupts) for, lets
say the harddisk or the ethernet?

anyway, glad you could '(re)solve?' your issues,

best,
Herbert


> 
> Kathy Frazier
> Senior Software Engineer
> Max Daetwyler Corporation-Dayton Division
> 2133 Lyons Road
> Miamisburg, OH 45342
> Tel #: 937.439-1582 ext 6158
> Fax #: 937.439-1592
> Email: kfrazier@daetwyler.com
> http://www.daetwyler.com
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
