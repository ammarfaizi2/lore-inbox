Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293163AbSCABHS>; Thu, 28 Feb 2002 20:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310271AbSCABD6>; Thu, 28 Feb 2002 20:03:58 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:43725 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S310289AbSCABBZ>;
	Thu, 28 Feb 2002 20:01:25 -0500
Date: Thu, 28 Feb 2002 20:01:13 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Peter Hutnick <peter@fpcc.net>
cc: Jason Cook <jasonc@reinit.org>, <linux-kernel@vger.kernel.org>
Subject: Re: wvlan_cs in limbo?
In-Reply-To: <200202282343.QAA15734@perth.fpcc.net>
Message-ID: <Pine.SGI.4.31L.02.0202281958550.5604431-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Peter Hutnick wrote:

> > pcmcia-cs does not build modules if, by fading memory, the kernel has
> > pcmcia and cardbus support enabled.
>
> RIght.  Turned it off.  It built a bunch of /other/ modules.

Try rebuilding the kernel without wireless support, then rebuilding
pcmcia-cs?

I built pcmcia-cs 3.1.31 against 2.4.17, and I have wvlan_cs in
/lib/modules/`uname -r`/pcmcia.

Email me offlist, and I'll send you configs and whatever else I can do to
help.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

