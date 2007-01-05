Return-Path: <linux-kernel-owner+w=401wt.eu-S1751203AbXAFHa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbXAFHa4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbXAFHaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:30:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2063 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751206AbXAFHay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:30:54 -0500
Date: Fri, 5 Jan 2007 17:17:36 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Albert Cahalan <acahalan@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se, torvalds@osdl.org
Subject: Re: kernel + gcc 4.1 = several problems
Message-ID: <20070105171735.GA4745@ucw.cz>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com> <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com> <8069085182dff3b0e63a661d81804dbb@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8069085182dff3b0e63a661d81804dbb@kernel.crashing.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >IMHO you should play such games with "g++ -O9", but 
> >that's
> >a discussion for a different mailing list.
> 
> For a different mailing list indeed; let me just point 
> out
> that for certain important quite common cases it's an 
> ~50%
> overall speedup.

Hmm, what code was that? 'signed int does not wrap around' does not
seem to provide _that_ much info...
							Pavel
-- 
Thanks for all the (sleeping) penguins.
