Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVFULjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVFULjc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFULis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:38:48 -0400
Received: from alog0132.analogic.com ([208.224.220.147]:34473 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261244AbVFULgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:36:32 -0400
Date: Tue, 21 Jun 2005 07:36:21 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Dave Jones <davej@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
In-Reply-To: <20050621113040.GB592@redhat.com>
Message-ID: <Pine.LNX.4.61.0506210733430.9577@chaos.analogic.com>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
 <20050621003203.GB28908@redhat.com> <Pine.LNX.4.61.0506210629110.8815@chaos.analogic.com>
 <20050621111301.GA592@redhat.com> <Pine.LNX.4.61.0506210714400.9115@chaos.analogic.com>
 <20050621113040.GB592@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Dave Jones wrote:

> On Tue, Jun 21, 2005 at 07:17:55AM -0400, Richard B. Johnson wrote:
>
> > >> Bullshit. The source is available to anybody who wants it.
> > >Great. Then please explain why you pull off this kind of crap..
> > >(DataLink/license.c)
> > Because it's true.
>
> kernel/module.c:1259 disagrees with you.
>
> static inline int license_is_gpl_compatible(const char *license)
> {
>    return (strcmp(license, "GPL") == 0
>        || strcmp(license, "GPL v2") == 0
>        || strcmp(license, "GPL and additional rights") == 0
>        || strcmp(license, "Dual BSD/GPL") == 0
>        || strcmp(license, "Dual MPL/GPL") == 0);
> }
>
> > >MODULE_LICENSE("GPL\0 They won't allow GPL/BSD anymore!");
>
> AFAICS, this is just plain deception. I suggest reading
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108304056922350&w=2
> especially the part about talking to lawyers.
>
> 		Dave
>

At the time the work-around was inserted it was FACT. I don't
spend my time rewriting license strings to accommodate the
whims of the latest GPL fanatic, thank you.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
