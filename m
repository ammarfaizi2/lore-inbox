Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264521AbTIIUmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTIIUmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:42:15 -0400
Received: from unthought.net ([212.97.129.24]:8074 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264521AbTIIUmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:42:09 -0400
Date: Tue, 9 Sep 2003 22:42:07 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Chris Meadors <clubneon@hereintown.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Panic when finishing raidreconf on 2.4.0-test4 with preempt
Message-ID: <20030909204206.GA11626@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Chris Meadors <clubneon@hereintown.net>, linux-kernel@vger.kernel.org
References: <1062883950.1341.26.camel@clubneon.clubneon.com> <20030909181131.GB9079@unthought.net> <1063135290.1119.32.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1063135290.1119.32.camel@clubneon.priv.hereintown.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 03:21:31PM -0400, Chris Meadors wrote:
...
> I'll mess around this evening a bit if I get a chance.  I really wasn't
> in the mood to see this error again (losing five years worth of data can
> do that to a person, but I've come to terms (with my own arrogance and
> stupidity, along with the data loss (just old e-mails and pictures, but
> stuff that is nice to hold onto anyway)) and pre-ordered Plextor's new
> DVD burner). But that does leave me with a few blank drives that I can
> beat on all anyone needs.

Eh, ok, I'm not really sure what you did...

You ran raidreconf once, and after the entire reconfiguration had run,
the kernel barfed.

Then what?  You re-ran the reconfiguration?  Same as before?

If so, then I can pretty much guarantee you that your data are lost. You
may get Ibas (ibas.no) to scrape off the upper layers of your disk
platters, run some pattern analysis on whats left, and possibly then
retrieve some of your old data, but that's about the only chance I can
see you having.

If you only ran raidreconf once, then there might still be a good chance
to get your data back.  To me it doesn't sound like this is the case,
but if it is, please let me know.

Sorry about your loss (but running an experimental raid reconfiguration
tool on an experimental kernel without backups, well...  ;)

> 
> I'll be putting -test5 on first.  I had planned on disabling the
> preempt, but since that was reported in the oops, I'll leave it on.

Ok. It would be interesting to see if the oops goes away when preempt is
disabled.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
