Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTJXVdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTJXVdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:33:11 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:63758 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262652AbTJXVdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:33:07 -0400
Date: Fri, 24 Oct 2003 14:33:04 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031024213304.GA29903@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3F8E552B.3010507@users.sf.net> <20031022122251.A3921@borg.org> <3F97498D.9050704@storm.ca> <bnbo18$49b$1@gatekeeper.tmr.com> <bnc3ru$kab$2@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnc3ru$kab$2@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to the humour impaired.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 08:59:42PM +0000, David Wagner wrote:
> bill davidsen wrote:
> >I know someone noted that frandom couldn't just replace urandom, but I
> >don't recall why.
> 
> Because we don't have enough confidence in the cryptographic
> security of frandom.

If that is the only reason there is no need for further
discussion on this thread.  The idea of adding /dev/frandom
is i think clearly rejected.  Frandom as replacement for
urandom is a future possibility.

The frandom author or someone else who cares enough can code
a patch that provides does do a drop-in replacement for
urandom.  Preferably that patch could have a build option to
chose which PRNG to use.  People that care can try the
patch.  Everyone else can ignore it.

In the mean time the cryptogeeks can analise it, bang on it,
sprinkle it with pixie dust, or whatever until there is
enough confidence or its weaknesses are known.

If after these things are done, months from now, it can be
considered a candidate, or not, for inclusion in some of the
speciality, distribution or development trees.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
