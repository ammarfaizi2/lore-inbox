Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTBAFxO>; Sat, 1 Feb 2003 00:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbTBAFxO>; Sat, 1 Feb 2003 00:53:14 -0500
Received: from pcp01184434pcs.strl301.mi.comcast.net ([68.60.187.197]:42663
	"EHLO mythical") by vger.kernel.org with ESMTP id <S264724AbTBAFxO>;
	Sat, 1 Feb 2003 00:53:14 -0500
Date: Sat, 1 Feb 2003 01:02:27 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
Message-ID: <20030201060227.GA29945@michonline.com>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es> <20030131222257.GA11011@mars.ravnborg.org> <mailman.1044055681.1939.linux-kernel2news@redhat.com> <200302010106.h1116XP08674@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302010106.h1116XP08674@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 08:06:33PM -0500, Pete Zaitcev wrote:
> 
> For the record, the userland which I posess does have a somewhat
> working Perl RPM, which originates from Red Hat 5.2, I believe.
> So, I cannot invoke "missing perl" argument in good conscience.
> However, I shudder to think what happens if I need to rebuild it
> for some reason.

Well, do "perl -v" and see if it's at least 5.004 (5.004.003 I think
would be better.)  If so, hpa's requirement that everything work on
5.004 is fine.  (And really, I don't believe that requirement is going
to be hard to follow, except that it does constrain the modules in use a
little bit - I'm pretty sure the Digest::MD5 was missing from the 5.004
default set of modules.)

> There's also a subject of a skillset. I know nil about Perl.
> (ok, I hacked sirc long ago. I don't think it counts.)

If you hacked sirc...  Well, that's an example of incredibly bad Perl,
so, you should be able to follow well-written and documented Perl, imo.

(I did an amazing amount of sirc hacking in my time, and it was an
exercise in pain, to be honest.)


-- 

Ryan Anderson
  sometimes Pug Majere
