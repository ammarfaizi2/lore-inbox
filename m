Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbTDWOZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTDWOZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:25:41 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:64989 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264048AbTDWOZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:25:32 -0400
Date: Wed, 23 Apr 2003 10:23:53 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423142353.GL354@phunnypharm.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423142131.GK820@hottah.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 04:21:31PM +0200, Stelian Pop wrote:
> On Wed, Apr 23, 2003 at 09:54:48AM -0400, Ben Collins wrote:
> 
> > Your patch leaves a race condition open. And no, I don't have a stripped
> > down patch. It's impossible for me to syncronize layers of linux1394
> > development with the timing of 2.4/2.5 development. The size of the
> > current 2.4 diff is only because of the amount of stuff merged from our
> > 2.5 tree and a serious code cleanup (fixing locking problems like you saw
> > here).
> 
> While this is a reasonable explanation, we are now in rc mode, and 
> your changes are not trivial, they could introduce a big pile of
> new bugs.
> 
> Marcelo, please revert the latest IEEE1394 changeset entirely.
> 
> Let's hope that things will happen differently in 2.4.22-pre :(

Uh no, reverting it will just re-introduce bugs that it fixed.
2.4.22-pre should have come around a long time ago. The only reason most
of the changes in 2.4.21-pre for ieee1394 are there is because of the
amount of time that 2.4.21-pre has been sitting around. I was trying to
hold off most of these changes for 2.4.22-pre, but .21-pre lingered for
so long it became unreasonable.

Then after a long huge pause, it suddenly goes -rc. Should that leave me
stuck? Don't think so.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
