Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbTDWOkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTDWOkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:40:09 -0400
Received: from [81.80.245.157] ([81.80.245.157]:53942 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S264056AbTDWOjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:39:23 -0400
Date: Wed, 23 Apr 2003 16:51:22 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423145122.GL820@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423142353.GL354@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 10:23:53AM -0400, Ben Collins wrote:

> > While this is a reasonable explanation, we are now in rc mode, and 
> > your changes are not trivial, they could introduce a big pile of
> > new bugs.
> > 
> > Marcelo, please revert the latest IEEE1394 changeset entirely.
> > 
> > Let's hope that things will happen differently in 2.4.22-pre :(
> 
> Uh no, reverting it will just re-introduce bugs that it fixed.

Maybe, but the version prior to 2.4.21-pre7 worked pretty good 
for me.

> 2.4.22-pre should have come around a long time ago. The only reason most
> of the changes in 2.4.21-pre for ieee1394 are there is because of the
> amount of time that 2.4.21-pre has been sitting around. I was trying to
> hold off most of these changes for 2.4.22-pre, but .21-pre lingered for
> so long it became unreasonable.

I entirely agree.

However, the patch we are discussing has only *6 days*. If you had
submitted it 2 months ago, there wouldn't be such problems.

[BTW: searching back the l-k archives doesn't find any occurances of
your patch. I guess you sended it directly to Marcelo...]

> Then after a long huge pause, it suddenly goes -rc. Should that leave me
> stuck? Don't think so.

Sure, you should continue development and submit a fresh new version
ready to be tested in 2.4.22-pre1/pre2. 

As for 2.4.21, well, we want something pretty well tested. Will this
be the case with your new mega-patch ? I don't think so. The safest
is to go back to a version which worked. At least the bugs of that
version are known, which is not the case for the new version.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
