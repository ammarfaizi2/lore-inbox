Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269273AbUISQuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269273AbUISQuH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269281AbUISQuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:50:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2741 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269273AbUISQuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:50:03 -0400
Date: Sun, 19 Sep 2004 17:50:00 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Jonathan Lundell <linux@lundell-bros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug e1000 failed after 32 times
Message-ID: <20040919165000.GI1191@gallifrey>
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com> <20040916221406.1f3764e0.akpm@osdl.org> <1095411933.10407.29.camel@sli10-desk.sh.intel.com> <20040917161920.16d18333.akpm@osdl.org> <414B7470.4000703@pobox.com> <p06110429bd735d9afd46@[10.2.4.30]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p06110429bd735d9afd46@[10.2.4.30]>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.5 (i686)
X-Uptime: 17:47:44 up 3 days,  4:45,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jonathan Lundell (linux@lundell-bros.com) wrote:

> Out of curiosity, though, isn't there a residual related problem, in 
> that a reinserted card gets a new eth# as well? Not insurmountable, I 
> suppose, but a bitch to automate.

I do wonder why the eth# still gets exported to users - its a royal
pain when you have multiple cards.  I guess naming by mac address
isn't ideal either when you want to hot swap one!  Naming by
pci slot would be kind of nice.

(I sometimes wish ether cards would have a good old fashioned dil
switch on so you could set an ID).

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
