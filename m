Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVK0JUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVK0JUX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 04:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVK0JUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 04:20:23 -0500
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:20058 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750952AbVK0JUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 04:20:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=xQe6Iq9qFyJacHKNg2xJPH0BTdU0UPyv+iGfDfYQu0PixXYRpSMikaiisPBr8vdKHHBm/jN6fWRGN9+bUurg6UCPwsrkxZc/navBklps0fOdKYOPHNvyaFiEUFzE9/QoRGWjg/cKcwPIL5Z/NDyc+d72xGKl40SWGmrIAisWCkI=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Bogus MCE upon resumption of system? - Resolved
Date: Sun, 27 Nov 2005 04:20:11 -0500
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200410101932.12431.shawn.starr@rogers.com> <20041020154854.GF26439@elf.ucw.cz> <200410201520.46957.shawn.starr@rogers.com>
In-Reply-To: <200410201520.46957.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511270420.11479.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.6.15-rc2 (or eariler .15 snapshot) The kernel now enables MCE checking 
on resumption from suspend from disk thus there is no more bogus MCEs.

-snip-
[4358769.531000] [nosave pfn 0x3c4]<7>[nosave pfn 0x3c5]<6>[4358769.531000] 
Intel machine check architecture supported.
[4358769.531000] Intel machine check reporting enabled on CPU#0.
[4358769.531000] swsusp: Restoring Highmem

Thanks, 

Shawn.

On Wednesday 20 October 2004 15:20, Shawn Starr wrote:
> Suspend to RAM,  haven't gotten around to rebuilding kernel with USB not
> compiled in.
>
> Can anyone verify this is a bogus MCE? it occurs only after resuming from
> suspend from RAM.
>
> Shawn.
>
> On October 20, 2004 11:48, Pavel Machek wrote:
> > Ahoj!
> >
> > > MCE: The hardware reports a non fatal, correctable incident occurred on
> > > CPU 0. Bank 1: f200000000000105
> > >
> > > Of note, when resume I see this MCE, though i suspect it is bogus upon
> > > resume.
> >
> > You did not tell me if it was suspend-to-disk or -to-RAM. Also you'd
> > better mail lkml... I know a little about MCEs.
> >
> >         Pavel
