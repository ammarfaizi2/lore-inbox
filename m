Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbTJAUa3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 16:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbTJAUa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 16:30:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34475 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262474AbTJAUa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 16:30:27 -0400
Date: Wed, 1 Oct 2003 21:30:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: DervishD <raul@pleyades.net>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       "Lisa R. Nelson" <lisanels@cableone.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
Message-ID: <20031001203019.GX7665@parcelfarce.linux.theplanet.co.uk>
References: <1065012013.4078.2.camel@lisaserver> <1065044031.2158.23.camel@wynken.reefedge.com> <1065019077.2995.22.camel@localhost.localdomain> <Pine.LNX.4.53.0310011204410.4059@chaos> <20031001192126.GB22367@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001192126.GB22367@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 09:21:26PM +0200, DervishD wrote:
 
>     If someone answers me something like "you are much of a dumb for
> understanding the answer, so I'll just tell you that you're wrong"
> (and believe me, that 'joke' about a well earned F in Unix 101 falls
> in this category IMHO), I wouldn't bother to thank...

You know, it's really not a joke.  Permissions model and meanings of
individual permission bits *is* Unix 101 material and not knowing it
(let alone claiming behaviour contrary to reality) will, indeed, earn
you F.

To be completely blunt, original posting contained a lie.  Given sequence
of operations had not been tried on "Sun Unix".  At all.  Everything else
would not get a reaction harsher than "you are thinking about behaviour
of directories with sticky bit set; without it write permissions on directory
are sufficient to remove files in it".  Probably with reference to Unix FAQ
(and maybe a nitpick to the above - append-only and immutable files are
not removable).

9:1 says that all original poster had actually tried was rm /tmp/<something>
on Solaris, which, of course, resulted in "permission denied".  The rest was
extrapolation.  Which is not particulary endearing, to put it mildly.

The way original poster had reacted to replies ("You are all wrong,
I Know(tm)") + reference to Great Experience(tm)(r) had warranted the
rest, IMO.

And yes, we all screw up from time to time.  Which is OK, provided that
when said screwup is noticed you admit it instead of throwing a temper
tantrum.
