Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265498AbTF2BIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 21:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbTF2BIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 21:08:25 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:38093 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265498AbTF2BIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 21:08:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: azarah@gentoo.org
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Date: Sun, 29 Jun 2003 11:25:39 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200306281516.12975.kernel@kolivas.org> <200306290230.40059.kernel@kolivas.org> <1056820945.14725.33.camel@nosferatu.lan>
In-Reply-To: <1056820945.14725.33.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306291125.39755.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jun 2003 03:22, Martin Schlemmer wrote:
> On Sat, 2003-06-28 at 18:30, Con Kolivas wrote:
> > On Sat, 28 Jun 2003 15:16, Con Kolivas wrote:
> > > For my sins I've included what I thought was necessary for this patch.
> >
> > And just for good measure here is the latest with a slight addition that
> > helps X smoothness over time. It gives the sleep_avg a little headroom so
> > it doesn't drop from interactive as easily with bursts of cpu activity.
>
> Have not tried this one, but previous had the same issues on this HT
> box.  Reverted the two patches, and I have no mouse jerkyness or laggy
> redraw of windows.
>
> Anyhow, will it be a wise move to try and get a scheduler that works
> fine for both UP and SMP ?

Indeed. I wasn't trying to make a UP only patch, and it was not finished 
(nothing ever is really).

Con

