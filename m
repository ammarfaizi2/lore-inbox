Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWIICWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWIICWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 22:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWIICWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 22:22:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:61206 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750925AbWIICWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 22:22:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ouFtgzVY909bfnklxk9APZfG+NYUsk5OOdBSsACD+uhI7SzVuHRHzQi5z24ybYb0SN2sPJ/SLig7BMao3Pf6LyK2p04zaLhxAnon9ggSjOAyG9g7UEzHnw0fsRBLhV+DWTEzXWFW4k1XAXqYncHupfLbogk7C9ioNyrXfD3der0=
Message-ID: <40f323d00609081922g2d3bcc76vc0921e1dd4a57607@mail.gmail.com>
Date: Sat, 9 Sep 2006 04:22:08 +0200
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
Cc: linux-kernel@vger.kernel.org, "Brice Goglin" <brice@myri.com>,
       "Greg Kroah-Hartman" <gregkh@suse.de>
In-Reply-To: <20060908125053.c31b76e9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060908174437.GA5926@plankton.ifup.org>
	 <20060908121319.11a5dbb0.akpm@osdl.org>
	 <20060908194300.GA5901@plankton.ifup.org>
	 <20060908125053.c31b76e9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 8 Sep 2006 14:43:00 -0500
> Brandon Philips <brandon@ifup.org> wrote:
>
> > However, udev seems to very upset about network device names:
> >
> > [udevd:3951]: Changing netdevice name from [eth1_temp] to [eth0]
> >
> > That showed up a few hundred times.  I am running version 093 so I will
> > try updating that later.
>
> That's OK - it's a debug patch which was added to help us work out why one
> or two people's net device names are getting trashed.  In fact we tracked
> it down to some silliness in NetworkMonitor, regarding which certain parties
> have yet to respond, iirc.
>
By the way, I don't use Network Manager, but wpa_supplicant (which is
used by networkmanager), and the device name corruption still happens
(but I think it is a userspace problem).

regards,

Benoit
