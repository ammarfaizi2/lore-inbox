Return-Path: <linux-kernel-owner+w=401wt.eu-S1751628AbWLMWJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWLMWJe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWLMWJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:09:34 -0500
Received: from mail.suse.de ([195.135.220.2]:55795 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbWLMWJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:09:33 -0500
Date: Wed, 13 Dec 2006 14:09:11 -0800
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061213220911.GA10677@suse.de>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com> <20061213210219.GA9410@suse.de> <45807182.1060408@mbligh.org> <20061213134721.d8ff8c11.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213134721.d8ff8c11.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 01:47:21PM -0800, Andrew Morton wrote:
> On Wed, 13 Dec 2006 13:32:50 -0800
> Martin Bligh <mbligh@mbligh.org> wrote:
> 
> > So let's come out and ban binary modules, rather than pussyfooting
> > around, if that's what we actually want to do.
> 
> Give people 12 months warning (time to work out what they're going to do,
> talk with the legal dept, etc) then make the kernel load only GPL-tagged
> modules.
> 
> I think I'd favour that.  It would aid those people who are trying to
> obtain device specs, and who are persuading organisations to GPL their drivers.

Ok, I have no objection to that at all.  I'll whip up such a patch in a
bit to spit out kernel log messages whenever such a module is loaded so
that people have some warning.

thanks,

greg k-h
