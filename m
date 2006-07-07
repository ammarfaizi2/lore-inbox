Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWGGVnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWGGVnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWGGVnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:43:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44042 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751223AbWGGVnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:43:04 -0400
Date: Fri, 7 Jul 2006 21:42:09 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Fox <david.fox@linspireinc.com>
Cc: Rohan Dhruva <rohandhruva@gmail.com>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org, Jan Rychter <jan@rychter.com>
Subject: Re: [Suspend2-devel] Re: swsusp / suspend2 reliability
Message-ID: <20060707214209.GD5393@ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz> <m2k66qzgri.fsf@tnuctip.rychter.com> <20060707135031.GA4239@ucw.cz> <a149495b0607070705p261b4690n919b4f97896bdc12@mail.gmail.com> <44AEA615.9040302@linspireinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AEA615.9040302@linspireinc.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Why not
> >take the best from both swsusp and suspend2, and get a 
> >nice
> >implementation into the kernel, that works most of the 
> >times !
> 
> Well, this is the ten thousand dollar question - why not 
> indeed?  Pavel says "Problems are in drivers, and 
> drivers are shared", but suspend2 works around this by 
> unloading certain drivers before suspending, and 
> otherwise hacking around the difficulties.  This is, I 
> think, what is meant when suspend2 is said to support 
> scripting.

Well, you do make same hacks with swsusp; powersaved does that for
example.

>  It may not be a pleasing approach from a 
> theoretical standpoint, but it seems to be the only way 

...but as it is not pleasing, it can't go anywhere near mainline.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
