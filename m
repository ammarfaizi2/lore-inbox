Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSEQQaa>; Fri, 17 May 2002 12:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316367AbSEQQa3>; Fri, 17 May 2002 12:30:29 -0400
Received: from fysh.org ([212.47.68.126]:41621 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S316339AbSEQQa2>;
	Fri, 17 May 2002 12:30:28 -0400
Date: Fri, 17 May 2002 17:30:24 +0100
From: Athanasius <Athanasius@miggy.org.uk>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Just an offer
Message-ID: <20020517163024.GB17483@miggy.org.uk>
Mail-Followup-To: Athanasius <Athanasius@miggy.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020517141928.GC6613@louise.pinerecords.com> <Pine.LNX.3.95.1020517103006.143A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 10:48:21AM -0400, Richard B. Johnson wrote:
> Where there is a will, there is a way. As others have reported, you
> can have an old "always-on" machine at the remote site. You can have
> LILO redirect kernel messages out the serial port to be viewed

   It strikes me that this is also in part a LILO 'problem'.  We could
use some way to tell LILO to only boot a given image _once_ as the
default, and thence reboot to the normal default.  Combine this with any
of the methods for remote reboot (hardware watchdog, other machine wired
to reset, whatever) and you can easily recover from a futzed new kernel.
   I'm sure LILO can find room for a single byte 'flag' for such things
and an extra per-config option in /etc/lilo.conf.

-Ath, checking the LILO docs to see if it does something like this
already...
-- 
- Athanasius = Athanasius(at)miggy.org.uk / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
