Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWJ0WIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWJ0WIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 18:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWJ0WIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 18:08:22 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53716 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750754AbWJ0WIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 18:08:22 -0400
Subject: Re: AMD X2 unsynced TSC fix?
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <45427E91.2000402@nortel.com>
References: <1161969308.27225.120.camel@mindpipe>
	 <200610271335.10178.ak@suse.de> <1161981682.27225.184.camel@mindpipe>
	 <45427E91.2000402@nortel.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 18:08:22 -0400
Message-Id: <1161986902.27225.206.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 15:48 -0600, Chris Friesen wrote:
> Lee Revell wrote:
> 
> > What exactly does that AMD patch do?
> 
> "...by periodically adjusting the core time-stamp-counters, so that they 
> are synchronized."
> 
> It sounds like they just periodically write a new value to the TSC. 
> Presumably they set the "slower" one equal to the "faster" one.
> 
> You'd likely still have windows where time might run backwards, but it 
> would be better than nothing.

The patch also apparently changes boot params to make the OS use the
ACPI PM timer, so it must not be a complete solution.

Lee

