Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTLUTnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTLUTnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:43:16 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:52107 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S263953AbTLUTnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:43:14 -0500
Date: Sun, 21 Dec 2003 14:40:40 -0500
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
Message-ID: <20031221194040.GG30397@gnu.org>
References: <20031218231137.GA13652@gnu.org> <20031221012504.GB21001@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221012504.GB21001@pegasys.ws>
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 20, 2003 at 05:25:04PM -0800, jw schultz wrote:

> > What am I to do?  Ignore the patent?  Or should I refrain from submitting
> > the patch I wrote, and look for an unencumbered algorithm instead?
> 
> This whole thing seems strange to me.
> 
> Why do you even know the algorithm is patented?  And if you
> knew it was, why implement it?  If you implemented it and
> then did a search you poisoned yourself.

I implemented the algorithm, and before submitting it, I asked
the authors of the paper I used to implement the algorithm what
the patent status of this algorithm is.  The paper doesn't say
anything about any patents (in retrospect, obviously it wouldn't.)


> I've not poked around in the routing code but it seems to me
> that the kernel would need a longest-prefix match algorithm
> already so you shouldn't have to look far for one.

There is one already, and it's suboptimal, to say it mildly.


> As for asking the patent holder for a license.  If the
> patent were owned by a network hardware company i cannot see
> them licensing it because the speed of their equipment is
> their competitive advantage.  But you indicated the the
> patent is not owned by the HW company but exclusively
> licensed.  An existing exclusive license would preclude
> FLOSS being granted a license and a gratis sublicense would 
> likely violate the existing license.

I asked this question on l-k because there seem to be many 'common'
techniques in wide use which have US patents covering them.

Considering the circumstances, yes, licensing is probably out of the
question.


> It would be completely OT to wonder at what point source
> code crossed the line of expressing information of public
> record into being a patent violation. <niggle>

I wouldn't be surprised if publishing source code implementing a patented
algorithm would itself be considered as a patent violation (I'm not saying
that it would make sense to me though.)

I think this l-k thread was sufficiently instructive for me to decide that
I won't be publishing my implementation of this algorithm, and I'll just
wait until another (free) LPM algorithm pops up.


--L
