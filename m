Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287163AbSAUPvH>; Mon, 21 Jan 2002 10:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287208AbSAUPu5>; Mon, 21 Jan 2002 10:50:57 -0500
Received: from [204.42.16.60] ([204.42.16.60]:46609 "EHLO gerf.org")
	by vger.kernel.org with ESMTP id <S287163AbSAUPuv>;
	Mon, 21 Jan 2002 10:50:51 -0500
Date: Mon, 21 Jan 2002 09:50:46 -0600
From: The Doctor What <docwhat@gerf.org>
To: linux-kernel@vger.kernel.org
Subject: Re: vm philosophising
Message-ID: <20020121095046.A30401@gerf.org>
Mail-Followup-To: The Doctor What <docwhat@gerf.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201180522020.19716-100000@falcon.etf.bg.ac.yu> <Pine.LNX.4.33L.0201180235210.32617-100000@imladris.surriel.com> <20020118154239.A11920@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020118154239.A11920@xs4all.nl>; from faasen@xs4all.nl on Fri, Jan 18, 2002 at 03:42:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tommy Faasen (faasen@xs4all.nl) [020118 08:47]:
> 2-DBMS: 1 or 2 big programs which sometimes even do their own
> memory management.Fragmentation and latency isn't issue here I
> think however moving ltos of data to and from swap is.

A lot of times a DBMS is bulit that way because they assume they
know better than the OS designer how memory should be managed.  Same
reason they usually use raw writting the the drive instead of using
the OS calls.

Is this right or fair?  I don't know.   But it does imply that if a
VM or FS layer for an OS performs well enough, that a DBM system
might be built that would be built to take advantage of the OS's VM
and FS layer.

Ciao!

-- 
"When you have to shoot, shoot! Don't talk."
		--Tuco (The Good, The Bad, and The Ugly)

The Doctor What: Kaboom!                         http://docwhat.gerf.org/
docwhat@gerf.org                                                   KF6VNC
