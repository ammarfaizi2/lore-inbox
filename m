Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131535AbRC3QiV>; Fri, 30 Mar 2001 11:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131534AbRC3QiM>; Fri, 30 Mar 2001 11:38:12 -0500
Received: from m54-mp1-cvx1a.col.ntl.com ([213.104.68.54]:23812 "EHLO
	[213.104.68.54]") by vger.kernel.org with ESMTP id <S131530AbRC3Qh7>;
	Fri, 30 Mar 2001 11:37:59 -0500
To: <sfr@canb.auug.org.au>
Cc: <david.balazic@uni-mb.si>, <apenwarr@worldvisions.ca>,
   <apm@linuxcare.com.au>, <linux-kernel@vger.kernel.org>,
   <linux-laptop@vger.kernel.org>
Subject: Re: kernel apm code (PR#128)
In-Reply-To: <200103280018.f2S0IBk29870@pcug.org.au>
From: John Fremlin <chief@bandits.org>
Date: 30 Mar 2001 17:36:03 +0100
In-Reply-To: sfr@canb.auug.org.au's message of "Wed, 28 Mar 2001 10:18:11 +1000 (EST)"
Message-ID: <m24rwbz024.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sfr@canb.auug.org.au writes:

[...]

> > AFAICS. I hacked together the following patch for it a while ago,
> > which updated APM_IOC_REJECT for slightly more recent kernels (be
> > warned, I think I made some mistakes)
> 
> Thanks for this, I will review it and post a patch based on it (with
> due accredition of course).

Not sure that would be an altogether good idea, because I think I made
a bit of a hash of it ;-)

Did you get Albert Cranford's version?  I would recommend it over mine
(though I have not yet looked at it).

[...]

> I did not say the I did not "like the idea of me implementing it, as
> some people at linuxcare (including Stephen) want to do it
> differently themselves".  

I did interpolate the connection between these two clauses. If it
truely did not exist, I apologise.

> What I said the first time was that I preferred the idea of a user
> mode daemon interacting with the kernel not the kernel forking and
> execing a new process for every event.

This has nothing to do with the interface presented to the APM driver.

[...]

> It is important when implementing an API (and that is what we are
> doing) to try to get it as right and stable as possible because
> other developers do not like interfaces changing ...

Maybe this is true in general but in this particular case the "API"
has only one user at the moment, which is APM, so it is hardly a fully
fledged abstraction layer. Do you argue that the current pm_send_all
interface is superior to the one in my patch?

[...]

-- 

	http://www.penguinpowered.com/~vii
