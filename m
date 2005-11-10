Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVKJA6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVKJA6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVKJA6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:58:03 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:6868 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751171AbVKJA6A (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:58:00 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: pomac@vapor.com
Subject: Re: New Linux Development Model
Date: Thu, 10 Nov 2005 00:55:58 +0000
User-Agent: KMail/1.8.92
Cc: marado@isp.novis.pt, Linux-kernel@vger.kernel.org, fawadlateef@gmail.com,
       hostmaster@ed-soft.at, jerome.lacoste@gmail.com, carlsj@yahoo.com
References: <1131500868.2413.63.camel@localhost> <1131539876.8930.44.camel@noori.ip.pt> <1131552065.2413.90.camel@localhost>
In-Reply-To: <1131552065.2413.90.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511100055.58322.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 16:01, Ian Kumlien wrote:
[snip]
> > I totally disagree. See: for those who don't crawl on lkml, don't
> > compile kernels or modules or stuff like that, they had two choices: be
> > without ipw2100 or ipw2200 or learn how to put the drivers in their
> > kernels. Now, with the stock kernel you have ipw* support, even if
> > limited for some uses. Most people will be happy with this version, but
> > yes, there's still work to be done. When there's a new version
> > considered stable it will get merged into the kernel. Until then, if you
> > want to ride the unstable horse, you'll have to patch it yourself into
> > the kernel.
>
> Since it has to be out of tree the way it is now, you don't patch or
> upgrade, you simply have to make it compile. And if you are happy with
> wlan driver that hardly does wep then you have some issues as well.

Eh? WEP seems to work here with different key sizes. I think most people 
should be satisfied with finally being able to use their wireless controller 
in ANY form on a Centrino laptop without having to find a driver!

> > If you want to simplify the process of building the unstable versios of
> > ipw* or if you think that the newer versions of ipw* should be
> > considered the new stable, or if you at some point disagree with ipw*
> > development model you should complain in ipw2100 mailing list at
> > http://lists.sourceforge.net/lists/listinfo/ipw2100-devel .
> > Kernel-related, the decision of supporting the latest stable is good and
> > justifiable.
>
> Thats why we have "experimental" drivers in the kernel?
>
> like, f.ex.:
> Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)
> New SysKonnect GigaEthernet support (EXPERIMENTAL)
>
> Or the protocols? (STCP, DCCP, etc)
>
> IF a unstable version of a driver is better for the user isn't it better
> to merge it as experimental instead of merging a old version that wreaks
> havock on users of newer kernels (and they will STILL run the unstable
> version on older kernels anyways).

I'm not sure what you mean by "wreaks havoc". There have been bugfixes, but 
they do not affect many general use-cases. Equally the WPA work really IS 
brand new.

The primary "havoc" I had when upgrading to 2.6.14 was finding the older 
firmware and co-installing it.

> Note: I use skge myself, so pointing out that they are experimental is
> in no way negative, i actually prefer it to the stable driver.

I really don't think this is your call. The driver maintainer can push 
whatever code he's most happy with for whatever reasons he likes. I'm 
confident that in time appropriate changes from 1.0.8 will make it into 
mainline.

Perhaps the only criticism here that is valid is that Intel haven't released a 
1.0.9 that builds against release quality (2.6.14) kernels _yet_. But at best 
that is a topic for another mailing list, not the LKML.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
