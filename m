Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290881AbSAaD2M>; Wed, 30 Jan 2002 22:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290880AbSAaD2D>; Wed, 30 Jan 2002 22:28:03 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:4761 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290881AbSAaD1t>;
	Wed, 30 Jan 2002 22:27:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Drew P. Vogel" <dvogel@intercarve.net>, Dave Jones <davej@suse.de>
Subject: Re: Public patch penguin
Date: Thu, 31 Jan 2002 04:32:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, patchbot-devel@killeri.net
In-Reply-To: <Pine.LNX.4.33.0201302042550.11522-100000@northface.intercarve.net>
In-Reply-To: <Pine.LNX.4.33.0201302042550.11522-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16W7xt-0000KX-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 31, 2002 02:48 am, Drew P. Vogel wrote:
> > It's been done before with various levels of success. Some would
> > like it, others (myself included) would likely not use it.
> > I've said it before, and I'll say it again. Any tool which requires
> > me to start up a web browser to do something productive is a major
> > nuisance.

Hi Dave,

> Honestly I feel the same. Unfortunately installing new tools to do this is
> also a larger task than should be required. Personally, I would like a
> public ftp archive for patches to reside. I don't have a
> machine/connection I can open up ftp though.

Agreed.  Please have a look at what we're doing here:

   http://killeri.net/cgi-bin/alias/ezmlm-cgi

It's too early to try the code, currently at version 0.0 (thanks to Rasmus 
Andersen for that, Kalle Kivimaa for the mail list).  The guilding design 
rule is to do everything with MTAs that submitters and maintainers _are 
already using_, and to do it _just as they do it now_, using a normal mail 
archive as the data base.  The only thing that changes is: you mail the 
patchbot instead of the maintainer.

Submitters will need to put some minimal number of additional lines in the 
body of the email, and it's possible we'll get the 'minimal number' down to 
zero for common cases (one line description comes from subject, long 
description comes from mail, purpose is implied by [BUGFIX] in subject line, 
etc).

Do you see anything to object to so far?

-- 
Daniel
