Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422953AbWBCVBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422953AbWBCVBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWBCVBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:01:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2491 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030238AbWBCVBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:01:19 -0500
Date: Fri, 3 Feb 2006 13:01:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
cc: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
In-Reply-To: <43E3BF5A.3040305@lwfinger.net>
Message-ID: <Pine.LNX.4.64.0602031258300.4630@g5.osdl.org>
References: <43E39932.4000001@lwfinger.net> <Pine.LNX.4.64.0602031007420.4630@g5.osdl.org>
 <43E3A001.7080309@lwfinger.net> <20060203205716.7ed38386@localhost>
 <43E3BF5A.3040305@lwfinger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Feb 2006, Larry Finger wrote:

> Paolo Ornati wrote:
> > On Fri, 03 Feb 2006 12:25:05 -0600
> > Larry Finger <Larry.Finger@lwfinger.net> wrote:
> > 
> > 
> > > Thanks for the explanation. I have to admit that git is pretty much a
> > > black box to me. I use the guide at http://linux.yyz.us/git-howto.html and
> > > it recommends using rsync. I'll have to figure out how to change to git
> > > protocol.
> > 
> > 
> > Just do:
> > 
> > git pull
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > 
> > :)
> > 
> 
> Got it now. Thanks.

You can also edit the file that describe your shorthand notation. If you 
normally do "git pull origin" just look into the ".git/remotes/origin" 
file, and I think you'll find it very obvious what it all does.

(If you used a really old version of git to create the archive originally, 
it might be ".git/branches/origin" instead).

		Linus
