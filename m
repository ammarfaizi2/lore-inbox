Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWHFW7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWHFW7l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWHFW7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:59:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24074 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750756AbWHFW7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:59:40 -0400
Date: Sun, 6 Aug 2006 22:59:12 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Masover <ninja@slaphack.com>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Bernd Schubert <bernd-schubert@gmx.de>, reiserfs-list@namesys.com,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Clay Barnes <clay.barnes@gmail.com>,
       Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060806225912.GC4205@ucw.cz>
References: <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <44CF87E6.1050004@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CF87E6.1050004@slaphack.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-08-06 11:57:10, David Masover wrote:
> Horst H. von Brand wrote:
> >Bernd Schubert <bernd-schubert@gmx.de> wrote:
> 
> >>While filesystem speed is nice, it also would be great 
> >>if reiser4.x would be very robust against any kind of 
> >>hardware failures.
> >
> >Can't have both.
> 
> Why not?  I mean, other than TANSTAAFL, is there a 
> technical reason for them being mutually exclusive?  I 
> suspect it's more "we haven't found a way yet..."

What does the acronym mean?

Yes, I'm afraid redundancy/checksums kill write speed, and you need
that for robustness...

You could have filesystem that can be tuned for reliability and tuned
for speed... but you can't have both in one filesystem instance.
-- 
Thanks for all the (sleeping) penguins.
