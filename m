Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVANMlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVANMlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 07:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVANMlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 07:41:55 -0500
Received: from main.gmane.org ([80.91.229.2]:49585 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261972AbVANMlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 07:41:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: jtjm@xenoclast.org (Julian T. J. Midgley)
Subject: Re: thoughts on kernel security issues
Date: Fri, 14 Jan 2005 12:10:07 +0000 (UTC)
Message-ID: <cs8cqv$jo5$1@sea.gmane.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <1105643984.5193.95.camel@localhost.localdomain> <20050113204415.GF24970@beowulf.thanes.org> <20050114102249.GA3539@wiggy.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: hanjague.menavaur.org
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: jtjm@skaffen.home.xenoclast.org (Julian T. J. Midgley)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050114102249.GA3539@wiggy.net>,
Wichert Akkerman  <wichert@wiggy.net> wrote:
>Previously Marek Habersack wrote:
>> So it sounds that we, the men-in-the-crowd are really left out in the crowd,
>> people who are affected the most by the issues. Since the vendors are not
>> affected by the bugs (playing a devil's advocate here), since they fix them
>> for their machines as they appear, way before they get public.
>
>vendor suffer from that as well. Suppose vendors learn of a problem in
>a product they visibly use such as apache or rsync. If all vendors
>suddenly update their versions or disable things that will be noticed as
>well, so vendors can't do that.

I don't buy that at all.  There are numerous reasons for updating
programs or disabling things, of which fixing security holes is but
one.  Furthermore, even if fixing security holes was the only reason,
updating a service would indicate only that a bug had been found.  It
doesn't tell the observer what the bug is, or how to exploit it, so it
doesn't increase the risk to the end users.  The observant black hat
now knows that there is a bug in, say, apache, and can set about
reading the source code to try to find it, but he was probably looking
there anyway, so I don't think that need worry you much.  

So, the reason for not updating the software isn't "letting the black
hats know", which leaves "not being seen to break the embargo" as the
only possible explanation for such action.  But the embargo is there
to protect the end users, not to protect the vendors, so what the hell
does it matter if the information that there is a (non-disclosed) bug
in $CRITICAL_SERVER leaks so that the vendors can ensure that their
users are not put in danger of downloading binaries from a compromised
machine.  

If instead the vendors have drunk so heavily from the kool-aid that
they believe they must leave their machines vulnerable in order either
not to break the (apparently flawed) rules of vendor-sec, or, even
worse, to avoid annoying some dime-a-dozen "security researcher" who's
desperate to make a big name for himself, then things have reached a
very sorry state indeed.

Julian
-- 
Julian T. J. Midgley                       http://www.xenoclast.org/
Cambridge, England.
PGP: BCC7863F FP: 52D9 1750 5721 7E58 C9E1  A7D5 3027 2F2E BCC7 863F

