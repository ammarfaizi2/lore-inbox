Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752526AbWKCQ3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbWKCQ3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbWKCQ3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:29:20 -0500
Received: from raven.upol.cz ([158.194.120.4]:8584 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1752526AbWKCQ3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:29:19 -0500
Date: Fri, 3 Nov 2006 16:35:29 +0000
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       trivial@kernel.org
Subject: Re: [patch] make the Makefile mostly stay within col 80
Message-ID: <20061103163529.GB16807@flower.upol.cz>
References: <200611020047.53658.jesper.juhl@gmail.com> <slrnekj6ps.2in.olecom@flower.upol.cz> <20061102201650.GA9237@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102201650.GA9237@uranus.ravnborg.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 09:16:50PM +0100, Sam Ravnborg wrote:
> On Thu, Nov 02, 2006 at 07:16:12AM +0000, Oleg Verych wrote:
> > 
> > On 2006-11-01, Jesper Juhl wrote:
> > > Trivial little thing really. 
> > > Try to make most of the Makefile obey the 80 column width rule.
> > 
> > I'm already working on it. I did a lot more stuff, but currently i'm
> > stuck with very first patch, i've tried to push to mister Andrew:
> > <http://marc.theaimsgroup.com/?l=linux-mm-commits&m=116198944205036&w=2>
> > 
> > As i'm using emacs, i cann't revert this open/save/close patch every
> > time. If someone with RH-based distro is willing to help, i'll be glad.
> > Version of make is Red Hat make-3.80-10.2.
> > 
> > Also, i want Sam Ravnborg to comment on that effort (e-mail added). Thanks.
> 
> Most of the time I spent on Linux development is in a 80xsomething so
> I support the effort to make it fit into 80 coloumn.
> But only if done sensible and not as a hard rule. Some stuff really
> is less readable if it is adjusted to fit into a 80 coloumn.
> 
> I do not support tabifying the Makefiles. In a makefile <tab> has
> a special interpretation and the rule of thumb is:
> 
> 1) Use tab to indent commands as make requires it
> 2) Commands spanning more than one line may be indented with tabs.
> 
> Avoid tabs in all other places.
> 
> This is not the same ruleset as used in the .c source but the difference
> here is that an assignment is not turned into a command in .c code
> just because it is prefixed by a tab.
> 
> At present I'm fed up with day time job that is almost around the clock
> time job. It will take a month before I will be active in kbuild area
> again so please be patient. If something really urgent shows up I
> can act - but just not much time to do so in.

Well, i mean my efforts on fixing top makefile (something in mm tree
already), optimizing (Kbuild.include option checking without tmp
files), implementing (checking sources without building it) and along
with this 80, whitespace, tabifying as inevitable thing.

You've been cc'd on everything. After i started my linux development
from top makefile, i've tried to act on most kbuild related lkml
messages.

Thus i wanted to hear something from kbuild maintainer(s).

> 	Sam
> 
____
