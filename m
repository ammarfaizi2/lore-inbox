Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbTJEHjU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 03:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbTJEHjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 03:39:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263004AbTJEHjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 03:39:18 -0400
Date: Sun, 5 Oct 2003 08:39:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andre Hedrick <andre@linux-ide.org>
Cc: Rob Landley <rob@landley.net>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031005073917.GK7665@parcelfarce.linux.theplanet.co.uk>
References: <200310041952.09186.rob@landley.net> <Pine.LNX.4.10.10310042320170.21746-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10310042320170.21746-100000@master.linux-ide.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 11:40:22PM -0700, Andre Hedrick wrote:
> 
> Tell me I can not publish a GPL w/ source code project which returns the
> original API's to their normal place in history, and I will show you that
> I can still draw the string on a bow.

_What_ original API?  I agree that silent adding _GPL to existing symbol
is obnoxious and warrants a patch that would revert the change.

However, if tomorrow the exported function disappears completely - tough
luck.  Nobody had ever promised to keep this "API" unchanged.  It's not
that it had been changed just for kicks (after all, you get to do changes
in a bunch of in-tree drivers are such change), but such changes had happened
and will happen.  And there's nothing you can do about that.

And folks, let's be honest.  Sturgeon was an optimist.  Way more than 90%
of code is crap.  The only way around that is to have a bunch of creatively
sadistic bastards go through said code and rip the authors a new one for
every hole they find (and yes, that includes ripping new ones to each other).

Judging by the vendor drivers that doesn't happen.  I don't care why that
doesn't happen - be it "they'll buy it anyway" or "we have no resources"
or "it's rude to the people who had done the original work" or "what do
you mean, review?".  Whatever.  Unless I have very good reasons to believe
that particular piece of code had been done right, crap it is.  Plain and
simple statistics.

Code from unknown programmers presumably written to unknown specifications
that had presumably passed unknown QA by unknown reviewers and testers with
unknown results and then had been shipped with unknown amount of pressure
exerted by sales?  Geez...  What a wonderful reason to assume that it would
be better than average...
