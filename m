Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWGGVj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWGGVj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWGGVj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:39:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42506 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932300AbWGGVj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:39:58 -0400
Date: Fri, 7 Jul 2006 21:39:17 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net
Subject: Re: swsusp / suspend2 reliability
Message-ID: <20060707213916.GC5393@ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz> <m2k66qzgri.fsf@tnuctip.rychter.com> <3aa654a40607070819v1359fb69l5d617f029940cc0e@mail.gmail.com> <20060707180310.ef7186d7.grundig@teleline.es> <20060707174424.GA9913@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707174424.GA9913@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-07-06 19:44:24, Olivier Galibert wrote:
> On Fri, Jul 07, 2006 at 06:09:39PM +0200, grundig wrote:
> > You may ask "why not merge suspend2", but from an objective
> > POV it's perfectly fine that some people asks "why don't
> > suspend2 people try to improve swsusp instead of rewritting
> > it? It may be easier to fix swsusp than replacint it with
> > suspend2"
> 
> Suspend2 is an improvement on swsusp.  What Pavel wants is something
> completely different and even less tested that suspend2 called
> uswsusp.

...which is already merged in 2.6.17, BTW. So what Pavel wants can be
translated as 'please use already merged code, it can already do what
you want without further changing kernel'.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
