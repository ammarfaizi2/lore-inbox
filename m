Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTHYOJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTHYOJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:09:51 -0400
Received: from amdext2.amd.com ([163.181.251.1]:8162 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S261898AbTHYOJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:09:43 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C080EF014@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: pavel@suse.cz
cc: davej@redhat.com, linux-kernel@vger.kernel.org, aj@suse.de,
       mark.langsdorf@amd.com, richard.brunner@amd.com
Subject: RE: Cpufreq for opteron
Date: Mon, 25 Aug 2003 09:09:26 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1354C7121009509-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz]
> Sent: Monday, August 25, 2003 8:51 AM
> To: Devriendt, Paul
> Cc: davej@redhat.com; linux-kernel@vger.kernel.org; aj@suse.de;
> Langsdorf, Mark; Brunner, Richard
> Subject: Re: Cpufreq for opteron
> 
> 
> Hi!
> 
> > > 4) given good hardware and debugged driver, will any of those
> > > BUG_ON()s ever trigger?
> > 
> > Only if there are BIOS problems. 
> 
> In such case, I believe best idea is to leave them in as BUG_ON(). On
> broken BIOS, it will kill machine cleanly, and hopefully bios is going
> to be fixed.
> 
> If broken BIOS is seen in retail, we'll need to solve this other way.
> 
> Does this seem okay to you?

My concerns with the BUG_ON() approach are :
  1. Ease of me debugging the problem, as some of the state data I would
     want to see is global, so it might not be in a backtrace.
  2. Taking the machine down when exestuation could continue.

You have more kernel experience than I do, so I am willing to accept your
advice. I am ok with it.

Thanks. Paul.

> 								Pavel
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> 

