Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289375AbSA2KQz>; Tue, 29 Jan 2002 05:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289363AbSA2KQp>; Tue, 29 Jan 2002 05:16:45 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:23682 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289375AbSA2KQg>;
	Tue, 29 Jan 2002 05:16:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 11:21:35 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <20020129095504.GC5485@emma1.emma.line.org>
In-Reply-To: <20020129095504.GC5485@emma1.emma.line.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VVOR-00009n-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 10:55 am, Matthias Andree wrote:
> On Mon, 28 Jan 2002, Rob Landley wrote:
> 
> > The holder of the patch penguin would feed Linus good patches, by Linus's 
> > standards. Not just tested ones, but small bite-sized patches, one per email 
> > as plain text includes, with an explanation of what each patch does at the 
> > top of the mail. (Just the way Linus likes them. :) Current pending patches 
> > from the patch penguin tree could even be kept at a public place (like 
> > kernel.org) so Linus could pull rather than push, and grab them when he has 
> > time. The patch penguin tree would make sure that when Linus is ready for a 
> > patch, the patch is ready for Linus.
> 
> Looks like a manual re-implementation of a bug/request/patch tracker
> like sourceforge's, bugzilla or whatever, with some additions.

And you load a patch into it by emailing to the bot, not via the web
interface.  The web interface is just for a) reporting b) maintainance, i.e., 
closing out a patch that got applied in some altered form, or applied with no 
notification to the bot, or obsoleted.

> A patch
> is added to the system, it gets a version tag, and you just pull it, and
> mark it closed if applied to Linus' tree. If Linus releases a new tree,
> the patch is marked stale until the maintainer uploads an updated patch
> or just reopens it to mark "still applies unchanged to new version". (No
> CVS involved, BTW.)

Yes, very much yes.  This way it just looks like regular email to Linus - 
except for some hopefully useful bookkeeping gack prepended to the top of the 
mail by the bot - and doesn't change the way he works at all.

-- 
Daniel
