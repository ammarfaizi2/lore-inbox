Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVFAP0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVFAP0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVFAPYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:24:52 -0400
Received: from opersys.com ([64.40.108.71]:46098 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261433AbVFAPXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:23:20 -0400
Message-ID: <429DD533.6080407@opersys.com>
Date: Wed, 01 Jun 2005 11:33:07 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050601143202.GI5413@g5.random> <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk> <20050601150527.GL5413@g5.random>
In-Reply-To: <20050601150527.GL5413@g5.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea,

I've been involved with understanding/fighting this patent for a very
long time. I must have read it at least a dozen times. To the best of
my understanding as a non-lawyer, I don't see how PREEMPT_RT could
fall as being covered by it.

Andrea Arcangeli wrote:
> The patent text goes like this "providing a software emulator to disable
> and enable interrupts from the general purpose operating system; 
> 
> marking interrupts as "soft disabled" and not "soft enabled" in response
> to requests from the general purpose operating system to disable
> interrupts; ".

What you are refering to is claim #7. The text does resemble this, but it's
in a wider context of all the other statements within that claim, the main
part being what I quoted earlier.

Now in regards to emulating interrupts in a general purpose OS, then this
has been done many times over prior to the patent. Here's one readily
available example in the Unix world:
http://www.usenix.org/publications/library/proceedings/micro93/stodolsky.html

Please drop this one Andrea.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
