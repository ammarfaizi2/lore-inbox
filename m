Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTLUBZR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 20:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTLUBZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 20:25:17 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:21515 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262104AbTLUBZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 20:25:10 -0500
Date: Sat, 20 Dec 2003 17:25:04 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
Message-ID: <20031221012504.GB21001@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20031218231137.GA13652@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218231137.GA13652@gnu.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause drowsiness.  Do not operate heavy machinery.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 06:11:37PM -0500, Lennert Buytenhek wrote:
> Hi,
> 
> Apologies for posting this OT question here, I didn't find this question
> answered in the FAQ.
> 
> There's a fast algorithm for longest-prefix match (as used in IPv4 routing
> table lookups) which I have implemented, and would like to submit for
> inclusion into the kernel (when 2.7 opens.)
> 
> However, I am aware that there is a patent on this algorithm, exclusively
> licensed to a major manufacturer of networking equipment.
> 
> What am I to do?  Ignore the patent?  Or should I refrain from submitting
> the patch I wrote, and look for an unencumbered algorithm instead?

This whole thing seems strange to me.

Why do you even know the algorithm is patented?  And if you
knew it was, why implement it?  If you implemented it and
then did a search you poisoned yourself.

I've not poked around in the routing code but it seems to me
that the kernel would need a longest-prefix match algorithm
already so you shouldn't have to look far for one.

As for asking the patent holder for a license.  If the
patent were owned by a network hardware company i cannot see
them licensing it because the speed of their equipment is
their competitive advantage.  But you indicated the the
patent is not owned by the HW company but exclusively
licensed.  An existing exclusive license would preclude
FLOSS being granted a license and a gratis sublicense would 
likely violate the existing license.

It would be completely OT to wonder at what point source
code crossed the line of expressing information of public
record into being a patent violation. <niggle>

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
