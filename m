Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263958AbSKCVyJ>; Sun, 3 Nov 2002 16:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSKCVyJ>; Sun, 3 Nov 2002 16:54:09 -0500
Received: from pdbn-d9bb86cf.pool.mediaWays.net ([217.187.134.207]:62731 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S263958AbSKCVyG>;
	Sun, 3 Nov 2002 16:54:06 -0500
Date: Sun, 3 Nov 2002 23:00:23 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Nicholas Wourms <nwourms@netscape.net>
Cc: Flavio Stanchina <flavio.stanchina@tin.it>, linux-kernel@vger.kernel.org
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021103220023.GA16889@citd.de>
References: <200211031809.45079.josh@stack.nl> <aq41b9$dt9$1@main.gmane.org> <3DB5E7CA00439C7E@smtp2.cp.tin.it> <3DC593A8.2030204@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC593A8.2030204@netscape.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 04:22:48PM -0500, Nicholas Wourms wrote:
> Flavio Stanchina wrote:
> >On Sunday 03 November 2002 21:38, Nicholas Wourms wrote:
> >
> >
> >>Stop whining, 2.5 kernels are development kernels -> not *expected* to
> >>work %100!
> >
> >
> >Correct me if I'm wrong, but we're here to work out the problems. That's 
> >one of the major meanings of "development", in my experience.
> >
> >I was bitten too: I loaded my 2.4.19 configuration and looked through most 
> >options, but I overlooked this keyboard/mouse thing. I think it's not 
> >turned on by default if you load an existing configuration, which is 
> >probably not what we want.
> >
> 
> This is true, but if you are going to make a report, make a 
> report, don't advocate changing something which works for 
> most as it stands.  From the subject, one got the idea that 
> people wanted to do some willy-nilly rearranging of the 
> configure options.  The real issue here is that you really 
> should *not* be copying 2.4 .config's over to a 2.5 tree. 
> That way you'll be forced to go through all the options and 
> get the proper "default" options for your platform enabled 
> automatically.

So here goes the suggestion:

The config gets a version-Tag.

Changes before the second dot in the version print a warning that you
should not copy configs between major-versions. (Maybe it is better to
default to exit with the warning and an option to override the exit.)

Only configs without a version-Tag are tricky. Maybe there is a good(tm)
config-option that can be used to guess if the config is from the
current major-version (=2.5). All other configs are "old(tm)".





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

