Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWHHXf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWHHXf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWHHXf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:35:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11220 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030314AbWHHXfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:35:55 -0400
Subject: Re: swsusp and suspend2 like to overheat my laptop
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nigel Cunningham <nigel@suspend2.net>, LKML <linux-kernel@vger.kernel.org>,
       Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org, pavel@suse.cz
In-Reply-To: <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	 <200608090750.40111.nigel@suspend2.net>
	 <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 19:35:44 -0400
Message-Id: <1155080145.26338.130.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 19:31 -0400, Steven Rostedt wrote:
> On Wed, 9 Aug 2006, Nigel Cunningham wrote:
> 
> >
> > The problem will be ACPI related, not particular to swsusp or Suspend2, which
> > is why you're seeing it with both implementations. I would suggest that you
> > contact the ACPI guys, and also look to see whether there is a bios update
> > available and/or a DSDT override for your machine. The later will help if the
> > problem is with your particular machine's ACPI support, the former if it's a
> > more general ACPI issue.
> >
> 
> Thanks for the response Nigel,
> 
> There does exist a recent bios update for this machine:
> 
> http://www-307.ibm.com/pc/support/site.wss/document.do?sitestyle=lenovo&lndocid=MIGR-58127
> 
> Hmm, it requires windows, and I've already wiped out that partition.  I
> did a search but it seems really scary to update the BIOS via Linux.
> 
> Anyone else out there have a Thinkpad G41 and has successfully upgraded
> their BIOS?

I would just report it to the ACPI people.  It's a bug if Linux does not
work with the same BIOS + DSDT that the other OS works on.

Lee

