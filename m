Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbUJYFyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUJYFyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 01:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUJYFyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 01:54:11 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:50058 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S261461AbUJYFyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 01:54:07 -0400
Date: Sun, 24 Oct 2004 22:53:38 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: jonathan@jonmasters.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
Subject: Re: How is user space notified of CPU speed changes?
Message-ID: <20041025055338.GG27633@ca-server1.us.oracle.com>
Mail-Followup-To: jonathan@jonmasters.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Robert Love <rml@novell.com>
References: <1098399709.4131.23.camel@krustophenia.net> <1098444170.19459.7.camel@localhost.localdomain> <1098508238.13176.17.camel@krustophenia.net> <1098566366.24804.8.camel@localhost.localdomain> <35fb2e590410231635616f10c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590410231635616f10c9@mail.gmail.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 12:35:46AM +0100, Jon Masters wrote:
> Out of sheer interest, you said you had an example box which did this.
> I've never actually seen a modern SMP setup with different cock
> frequencies (even accepting it's possible) - can you give me a more
> modern example? I'm sure they're out there, I've just missed it, and I
> have to confess to not being aware that Linux supported this kind of
> setup.

	I have a dual celeron with a 433 CPU and a 466 CPU in the slots.
It works, as long as you don't rely on TSC synchronicity.  Also, IBM
x440 boxes don't sync the TSCs between each group of 4 CPUs (that is,
each group of 4 is synced internally, but different from each other
group of 4).

Joel

-- 

"Vote early and vote often." 
        - Al Capone

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
