Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268349AbUGXIMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268349AbUGXIMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 04:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUGXIMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 04:12:09 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3507 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S268349AbUGXIMG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 04:12:06 -0400
From: Rob Landley <rob@landley.net>
To: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: Interesting race condition...
Date: Sat, 24 Jul 2004 03:13:19 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200407222204.46799.rob@landley.net> <20040723073300.GA4502@ip68-4-98-123.oc.oc.cox.net>
In-Reply-To: <20040723073300.GA4502@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407240313.19053.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 July 2004 02:33, Barry K. Nathan wrote:
> On Thu, Jul 22, 2004 at 10:04:46PM -0500, Rob Landley wrote:
> > Seems like some kind of race condition, dunno if it's in Fedore Core 1's
> > ps or the 2.6.7 kernel or what...
>
> I've seen this too, on Fedora Core 2 and pretty recent (within the last
> 2 weeks) fc-devel. Hard enough to reproduce (and not enough of a bother
> IMO) that I haven't filed it in Bugzilla though.
>
> (Now that you mention Fedora Core, I can't remember seeing this with any
> other distributions.)
>
> -Barry K. Nathan <barryn@pobox.com>

Oh I can't reproduce it either.  (Maybe if I set some kind of loop and left it 
running for a few days...)

I just thought it was really odd.  There should be a null terminator before 
the environment variables, and it's getting stomped somehow.  Maybe it was 
right as the process was starting...?

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

