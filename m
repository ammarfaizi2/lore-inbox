Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWAUHWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWAUHWU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 02:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWAUHWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 02:22:19 -0500
Received: from free.wgops.com ([69.51.116.66]:61713 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751007AbWAUHWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 02:22:19 -0500
Date: Sat, 21 Jan 2006 00:22:03 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Matthew Frost <artusemrys@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org, James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Development tree, PLEASE?
Message-ID: <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>
In-Reply-To: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 7:19:58 PM -0800 Matthew Frost 
<artusemrys@sbcglobal.net> wrote:

>
>
> --- Matthew Frost <artusemrys@sbcglobal.net> wrote:
>
>> No.  Wrong.  If there're a whole grab bag, as you say, then you should
>> post each, as a separate issue, possibly with consistent proposals for
>> fixing them.  Follow protocol.  Posting a "The Kernel Is Falling" email
>> gets people riled up, makes you look foolish, and gets nothing fixed.
>> Noise.  Send signal.  We'll wait.
>
> Be it noted that you have clarified, and that the issue involves ARM and
> trying to juggle solutions that have simpler alternatives; I just didn't
> look low enough in the thread first.  My comments are superfluous at this
> point.

The thread in part diverged into three separate discussions more or less. 
I still have a big problem with how the development of the kernel is being 
done now, with a total lack of a stable branch.  Stable in my mind also 
means not a moving target for developers, nor maintainers.  Try maintaining 
a lot of very demanding applications that must run right so changes must 
always be fully tested before rolling out.  It makes it nearly impossible 
to do that when the kernel has no stable branch that's mostly bug fixes, 
instead any time a bug is discovered a full process must be started to make 
sure no new bugs in all the new code features, etc, that became present 
during the interim are not found.  It makes maintenance a real nightmare 
for atleast one environment in which I maintain production systems, and 
also makes it rather a bit more difficult in others too since changes must 
be vetted.  Not necessarily *all* of them, but when there's lots of changes 
it's hard to track whats 'interesting' and what doesn't affect one.  If 
there was/is a stable tree then when bugfixes come they are applied there, 
and one can upgrade along that tree with much less concern about things 
changing underfoot.

That's my root problem.  The devfs stuff is just ancillary and came about 
as examples of where I've been backed into a no win situation.  Yes, I know 
it was and is deprecated, fact is I didn't write all of the code that is 
the problem, and some of it I don't even have access to either.  Yes some 
of it is maintained by the distro, some by third parties, some by me.  But 
they're all being broken because we either throw out or try to return 
systems with these newer chipsets, or start forking and maintaining 
separate kernel trees.

Don't get me wrong, I understand the reasons, and I apologize for being so 
late to the party.

Over on my end I have to make a decision as to if I have the time to try 
to...promote/lead some sort of effort along these lines so that we can all 
benefit instead of just those willing to use and install RedHat or SuSE or 
Debian or Ubuntu or whatever distro.

I think this has gotten to beating a dead horse severely now, that may have 
already been dead when I walked into the room, and for that I apologize.
