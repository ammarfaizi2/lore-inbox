Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVHQSb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVHQSb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVHQSb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:31:29 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:48342 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751197AbVHQSb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:31:29 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43036F80.2020406@cybsft.com>
References: <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
	 <1124287505.5764.141.camel@localhost.localdomain>
	 <1124288677.5764.154.camel@localhost.localdomain>
	 <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>  <43036F80.2020406@cybsft.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 14:31:06 -0400
Message-Id: <1124303466.5247.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 12:10 -0500, K.R. Foley wrote:

> This one has been biting me in the shorts since going to the 2.6.13-rc? 
> RT series on my older SMP system at home. In every case the system hangs 
> on shutdown and requires a hard reset. I just hadn't had the time to 
> check into it. I was just in the process of building 2.6.13-rc6 without 
> RT to check if it still happened. Guess I won't bother now. :-)

On my AMD SMP box, the system boots with no problems. It did lock up on
shutdown right after it showed the nfsd bug.  My laptop still locks up
on start-up  so I need to take a look at it.  It's hyper-threaded and
not normal SMP, although I don't think that would make much of a
difference.  I'll copy over my config of my AMD box to my laptop, and
make just the changes that are required for the hardware, and see if it
boots farther.

When I ran my laptop in UP, on shutdown it also saw the nfsd problem,
but it never locked up.  My AMD SMP box did lock up.

-- Steve


