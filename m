Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbVJEXIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVJEXIF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbVJEXIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:08:05 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:48393 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030424AbVJEXID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:08:03 -0400
To: Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
	<35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com>
	<87oe66r62s.fsf@amaterasu.srvr.nix>
	<20051003153515.GW7992@ftp.linux.org.uk>
	<87zmpqbcws.fsf@amaterasu.srvr.nix>
	<21d7e9970510051411y2f2871a7mafa2e96cce277657@mail.gmail.com>
	<87br23odls.fsf@amaterasu.srvr.nix>
	<21d7e9970510051557u42ae32f0rca46e951c5da536f@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: well, why *shouldn't* you pay property taxes on your editor?
Date: Thu, 06 Oct 2005 00:07:56 +0100
In-Reply-To: <21d7e9970510051557u42ae32f0rca46e951c5da536f@mail.gmail.com> (Dave
 Airlie's message of "Thu, 6 Oct 2005 08:57:26 +1000")
Message-ID: <8764sbwoj7.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, Dave Airlie uttered the following:
>> I misspoke. Some of the non-DRM API changes around 2.6.12 broke the
>> 6.8.2 mach64 module in DRI CVS; the development version builds again,
>> and nearly works.
> 
> But that's my point if you had a previously working mach64 with 6.8.2
> with a DRM from around then, and a kernel upgrade broke the DRM you
> should be just able to upgrade the DRM to the latest DRM CVS, there
> isn't any such thing as a 6.8.2 DRM,

Ah. So, er, the DRM<-> userspace protocol is stable, then?

Looks like I was working on bad assumptions (assuming the DRM and X were
tied). I'm not sure where those assumptions came from. Possibly just
that they shared a CVS repo, although I'd hope I'd had more evidence
than that. I realy can't recall.

>                                      you'll only cause much more
> issues trying to fix an issue in the kernel side by also
> simultaneously upgrading userspace... as you've no fixed working point
> to try from..

That's OK, the -RC0 X server actually works better than the 6.8.2 one
for my application, and this gives me an excuse to report some bugs
before 6.9/7.0 is released :)


Thanks for the advice, anyway: I'll certainly bear it in mind in future.

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
