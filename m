Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbVKBQh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbVKBQh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbVKBQh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:37:28 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:49339 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965127AbVKBQh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:37:28 -0500
Subject: Re: 2.6.14-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <cb2ad8b50511020807y4617c6a4pcd0ee27b635c9c34@mail.gmail.com>
References: <20051030133316.GA11225@elte.hu>
	 <1130900716.29788.22.camel@localhost.localdomain>
	 <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
	 <1130902342.29788.23.camel@localhost.localdomain>
	 <cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com>
	 <20051102102116.3b0c75d1@mango.fruits.de>
	 <cb2ad8b50511020635qb355f33w6f3638972556c242@mail.gmail.com>
	 <20051102144015.GA19845@elte.hu>
	 <cb2ad8b50511020645i23c164d4h7140c4c352159974@mail.gmail.com>
	 <1130945876.29788.28.camel@localhost.localdomain>
	 <cb2ad8b50511020807y4617c6a4pcd0ee27b635c9c34@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 02 Nov 2005 11:37:09 -0500
Message-Id: <1130949429.29788.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope you guys (Ingo and Thomas) are done changing the API to
ktime_to_timespec.  I have over 200 debug statements doing this
conversion. Unfortunately, I didn't make it into a separate macro, so I
had to go by hand converting all of these.  

They are temporary (but still needed) debugging, that I did cut & paste
mostly with, and modified them to what was needed.  But its still to
complex to make a script make the changes.  Well it will be easier to do
it by hand.

Hmm, maybe it is time to make a macro out of this too :-/

-- Steve


