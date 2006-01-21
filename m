Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWAUWlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWAUWlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWAUWlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:41:23 -0500
Received: from free.wgops.com ([69.51.116.66]:36356 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751212AbWAUWlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:41:23 -0500
Date: Sat, 21 Jan 2006 15:40:50 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Lee Revell <rlrevell@joe-job.com>, Sven-Haegar Koch <haegar@sdinet.de>
Cc: Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Development tree, PLEASE?
Message-ID: <3B0BEE012630B9B11D1209E5@dhcp-2-206.wgops.com>
In-Reply-To: <1137881882.411.23.camel@mindpipe>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com>	
 <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>	
 <1137829140.3241.141.camel@mindpipe>	
 <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de>
 <1137881882.411.23.camel@mindpipe>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 21, 2006 5:18:01 PM -0500 Lee Revell <rlrevell@joe-job.com> 
wrote:


> You just illustrated perfectly why the new development model is needed.
>
> If 2.6.8 does not even work on newer machines, then obviously the rapid
> pace of development is needed in order to support new hardware.  You
> can't have a kernel that supports the latest and greatest hardware
> without the possibility of introducing bugs.

I don't feel that statement is true in all cases.  It's true in a lot of 
cases yes, but sometimes 'support' is really simply a matter of techinga 
module one more PCI ID.  Or adding in a few lines of code for a different 
PHY in the case of an ethernet adapter/MAC.  You also don't need to change 
say the queue elevator mechanism to support a new SATA chipset.  What the 
complaint is from production systems is the fact that in many many cases 
for new hardware support all that's needed is the little bit of code way 
out on the edge, without changing anything else.  While I am of the opinion 
new hardware support in a maintenance/bugfix/stabel kernel is a gray area, 
I can see where there are many times where it could be done, without 
introducing excessive change.

Right now the most obvious is the udev/devfs problem, at some point you're 
forced to lose that, that's fine, but there's nowhere to go for bugfixes. 
That's *ONE* case.  There WILL be more/others, possibly ones that are more 
disruptive.  Yes distro's/etc should help, but some of us aren't using 
distro's.  Which is why I started the thread is to try to get a community 
based longer lived stable tree.  Hopefully one that distro's would also 
use, and contribute bugfixes and patches to, much the same way as we have 
had in the past, but without directly taking the mainline/core team since 
they've decided (and I don't begrudge them this at all) that it is too much 
work to continue maintaining a stable tree, as well as developing, the 
kernel.

If possible I'd like Sven (even privately) to summarize does not work in a 
little bit clearer way. IE what bits don't work, or does it just completely 
fail to boot?  TIA!  I think he and I are seeing the same problems and are 
on the same page with this overall larger issue.

>
> Lee
>
>



--
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
