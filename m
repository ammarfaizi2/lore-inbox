Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWGHXzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWGHXzE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 19:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWGHXzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 19:55:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40594 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932345AbWGHXzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 19:55:01 -0400
Date: Sun, 9 Jul 2006 01:54:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Message-ID: <20060708235434.GG2546@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <200607082052.02557.rjw@sisk.pl> <20060708211003.GC2546@elf.ucw.cz> <200607090828.36834.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607090828.36834.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > It's only too slow on swsusp. With Suspend2, I regularly suspend 1GB
> > > > images on both my desktop and laptop machines. I agree that it might be
> > > > slower on a
> >
> > uswsusp is as fast as suspend2. It does same LZF compression.
> 
> I agree for uncompressed images - I tried timing the writing of the image 
> yesterday. I'm not sure about LZF though, because I couldn't get it to 
> resume. I'd be interested to see it really be as fast as suspend2 with 
> compression.

Is there any way to help you? I assume normal swsusp resumes okay so
it is not driver problem?

> > Do you think you could get some repeatable benchmark for Rafael? He
> > worked quite hard on feature only to find out it makes little difference...
> 
> Sure, but it will mean more if all of the tests are run on the same system, so 
> I'll have another go at getting uswsusp to resume, when I get the chance.

Thanks.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
