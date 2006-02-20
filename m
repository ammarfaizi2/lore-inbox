Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWBTToe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWBTToe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWBTTod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:44:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63109 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932657AbWBTToc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:44:32 -0500
Date: Mon, 20 Feb 2006 20:43:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Olivier Galibert <galibert@pobox.com>,
       Nigel Cunningham <nigel@suspend2.net>,
       Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: suspend2 review [was Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)]
Message-ID: <20060220194356.GK19156@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219234212.GA1762@elf.ucw.cz> <200602201210.58362.nigel@suspend2.net> <20060220124937.GB16165@elf.ucw.cz> <20060220170537.GB33155@dspnet.fr.eu.org> <20060220171000.GF19156@elf.ucw.cz> <20060220183136.GE33155@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220183136.GE33155@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 19:31:36, Olivier Galibert wrote:
> On Mon, Feb 20, 2006 at 06:10:00PM +0100, Pavel Machek wrote:
> > On Po 20-02-06 18:05:37, Olivier Galibert wrote:
> > > On Mon, Feb 20, 2006 at 01:49:37PM +0100, Pavel Machek wrote:
> > suspend2 received no such review, and still people claim it is
> > reliable.
> 
> Plain numbers.  Just count the "suspend2 works for me which swsusp
> doesn't".  I doubt it's purely luck, even if simply moving code around
> can change behaviours.

Well, people with broken swsusp tend to try suspend2... that's why you
see so many reports. if you merged suspend2 and dropped swsusp, it
would be the other way around. 

> > "I wish they'd kill suspend2 project, it already did enough
> > damage." (Half joking here, but suspend2 split user/development
> > community, and that's not good).
> 
> Yes, that's annoying.  But be careful, you seem to be automatically
> rejecting everything Nigel at that point, or at least that's what it
> looks like.

I'm not rejecting _everything_ Nigel does, but I have seen very little
acceptable kernel patches from him.

> You do what you want, obivously, but I suspect your reviews of the
> suspend2 code would be way more interesting if you accepted it's not
> uswsusp.  Right now, they look more religious/political than really
> technical.

Feel free to review suspend2 yourself. You are likely to find many
small issues, and Nigel is likely to fix them; but that's useless: as
long as big issues are not fixed, code is not suitable for mainline
merge.

(And it is going to be easier to do it in userspace using existing -mm
infrastructure then to clean suspend2 patches).

Feel free to review suspend.sf.net code if you want to help; testing
would be useful at this point, too.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
