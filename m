Return-Path: <linux-kernel-owner+w=401wt.eu-S932651AbWLZOmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbWLZOmp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 09:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWLZOmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 09:42:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56755 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932651AbWLZOmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 09:42:44 -0500
Date: Tue, 26 Dec 2006 15:42:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Mobily <merc@mobily.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Putting the sdhci to sleep safely [with attachments]
Message-ID: <20061226144233.GB2066@elf.ucw.cz>
References: <458FA64E.7070501@mobily.com> <20061225211432.GA2460@elf.ucw.cz> <4590756F.1090603@mobily.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4590756F.1090603@mobily.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> So, here I am... please find attache my lspci and the log of what
> >> happens when the computer is put to sleep.
> >>
> >> I would also be happy to organise a bounty for this bug to be fixed.
> > 
> > :-). Just hunt it yourself. It is probably easier than organizing a bounty.
> 
> OK. I had a look at the code, and I foind it depressing. Not because it
> was bad, but because it reminded me of how hopeless I am!
> I can do my best to get you guys to communicate, *and* to get some
> testing done - I am more than happy to spend as long as it takes
> testing, compiling patches, and putting my laptop to sleep over and over
> and over again. But coding... nope. Not on *this* code...

Come on, C is not that hard.

> > Ouch... you failed to mention what kernel you are using?
> 
> I told you I'd embarrass myself...
> 
> Linux merc-laptop 2.6.19-7-generic #2 SMP Mon Dec 4 16:46:19 UTC 2006
> i686 GNU/Linux

Okay, so trying 2.6.20-rc2 is good first step.

And then description what the problem is. My machine sleeps okay with
sdhci loaded... If I can reproduce, chance to do something about it
gets bigger.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
