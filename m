Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbRL0Vux>; Thu, 27 Dec 2001 16:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282843AbRL0Vun>; Thu, 27 Dec 2001 16:50:43 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:61657 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S282781AbRL0Vuc>; Thu, 27 Dec 2001 16:50:32 -0500
Subject: Re: replacing strtok() with strsep()
From: Philip Harvey <harveyp@coventry.ac.uk>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112272211480.15706-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112272211480.15706-100000@Appserv.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 27 Dec 2001 21:52:41 +0000
Message-Id: <1009489962.8806.3.camel@arrakis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-27 at 21:14, Dave Jones wrote:
> Someone (I forget who) took a run-through about 6 months back.
> AFAIK, they still sit in the last -ac tree, and not all (if any) of them
> got merged. If I get bored/desperate for patches to merge, I'll resurrect
> them for -dj. There are some other bits I keep meaning to dig out of
> Alans old tree, so if you decide to go do this and just bring these in
> sync for 2.5, I've no problem putting them in -dj until such a time
> for them to get maintainer-review/testing/merging.
> 
> The kernel-janitor list archives should hold copies of some of them.
> (See the sf page for details)

theres some individual patches for single files dating back a while, but
nothing comprehensive. i'll start tieing things together for 2.5,
perhaps starting with the  fs/ subtree which nobody seems to have
touched in a while.  it would be nice to declare 2.5 a strtok free zone.
most people are using strtok to seperate options, using exactly the same
syntax.  what are your thoughts on creating a strsep() macro to replace
them?

-phil

