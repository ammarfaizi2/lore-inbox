Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265467AbSJaWsY>; Thu, 31 Oct 2002 17:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265468AbSJaWsY>; Thu, 31 Oct 2002 17:48:24 -0500
Received: from almesberger.net ([63.105.73.239]:64007 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265467AbSJaWsW>; Thu, 31 Oct 2002 17:48:22 -0500
Date: Thu, 31 Oct 2002 19:54:42 -0300
From: Werner Almesberger <wa@almesberger.net>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
Message-ID: <20021031195442.Y1421@almesberger.net>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com> <20021031031932.GQ15886@ns> <1036098562.12714.50.camel@cog> <20021031184933.B2599@almesberger.net> <1036103533.12714.71.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036103533.12714.71.camel@cog>; from johnstul@us.ibm.com on Thu, Oct 31, 2002 at 02:32:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> Ugh, that seems dangerous. Too many forgotten ACL links and then I could
> accidentally give a vague acquaintance access to all my data meant for
> close friends. 

The idea is that you'd typically have (a) (small number of) specific
location(s) where you keep your files representing groups, e.g.
$HOME/acls/ for your personal lists, maybe ~project/acls/ for
projects, etc.

If you think already this is dangerous, then you should be
terrified by regular, non-aggregateable ACLs ;-)

I'm not saying that ACLs aren't useful, only that the lack of
aggregateability makes them hard to maintain, so that people
frequently fall back to setup scripts that simple re-create
their ACL configuration. Once you're at this point, ACLs have
lost much of their usefulness, and you might as well use some
suid program that creates groups for you.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
