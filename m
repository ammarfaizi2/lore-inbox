Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283594AbRL1AZf>; Thu, 27 Dec 2001 19:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283603AbRL1AZZ>; Thu, 27 Dec 2001 19:25:25 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:8715 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S283594AbRL1AZM>;
	Thu, 27 Dec 2001 19:25:12 -0500
Date: Thu, 27 Dec 2001 22:25:53 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Dave Jones <davej@suse.de>, Steven Walter <srwalter@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Message-ID: <20011227222553.G30930@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Dave Jones <davej@suse.de>, Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011227202345.B30930@conectiva.com.br> <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de> <20011227163130.N12868@lynx.no> <20011227214047.D30930@conectiva.com.br> <20011227171130.O12868@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227171130.O12868@lynx.no>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 27, 2001 at 05:11:30PM -0700, Andreas Dilger escreveu:
> On Dec 27, 2001  21:40 -0200, Arnaldo Carvalho de Melo wrote:
> > this already happens for the net/ directory to some degree, look at
> > net/README, the problem, as with MAINTAINERS, is that is way outdated,
> > listing Alan, for example, as the maintainer for net/core...
> 
> Well, if the MAINTAINERS file isn't up-to-date (which I know it isn't,
> see "Remy Card" as ext2 maintainer) then there isn't much that can be
> done by users/developers to submit patches to the right people at all.
> I think part of the problem is Linus' hesitance to be authoritarian and
> add/remove people from the MAINTAINERS list if they don't specifically
> ask for the change (and submit a patch to that effect).

Yup, Linus told this in a recent thread (this one?), and Al seems still not
interested in having his name there, its his right, but the fact is that he
_is_ the one doing maintainance for the VFS, so I don't think that putting
his name there would be something bad for him or whatever, but hey, if
Linus isn't authoritarian wrt this and Al doesn't want to have his name
listed there, what can we do? Ditto for other de-facto maintainers that are
not listed there.

And BTW, a janitor did something like: look at maintainers? nothing there?
send a message to all the addresses in the source file touched, what did he
got? some responses, yes, but _tons_ of bounces...

- Arnaldo
