Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWBCStk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWBCStk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWBCStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:49:40 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:28736 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030221AbWBCStj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:49:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FtdQ/oM4i/OH80hddts7vrxan0EIEoCIWNGPxh2i1YSXXjOnDmwxzU/3ja8bk2F/cm5/j6HbRa6JdQi9B7NCsizkuddwtXPsq2xggD4OtKPr7LPFJpduVcdWpYaGjH7hVEnMnH8bILeUY7eCWhL8paDcJUnPyo1RH0bqn1IVgXg=
Message-ID: <58d0dbf10602031049k380d83a4v@mail.gmail.com>
Date: Fri, 3 Feb 2006 19:49:38 +0100
From: Jan Kiszka <jan.kiszka@googlemail.com>
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: WLAN drivers
Cc: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
In-Reply-To: <1138969138.8434.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138969138.8434.26.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takis!

2006/2/3, Panagiotis Issaris <takis.issaris@uhasselt.be>:
> And now the reason I'm sending this to this mailing list: Which wireless
> network cards are you all using and which ones would you recommend? Is
> anyone using USB wireless network cards (without using ndiswrapper)?
>

I can recommend RalinkTech-based USB dongles. I have an Asus WL-167g
running 24/7 in ad-hoc mode with the "oldgen" driver. It's quite
stable, which means that I once in a few weeks have to unload/reload
the driver to get it working again. Might be ad-hoc-related which is
problematic with many drivers I saw so far. The driver project
(http://rt2x00.serialmonkey.com) currently aims at a cleaner revison,
but that one is not yet usable.

Additionally, RalinkTech is quite open towards the community. We
easily got support for an ongoing work to write an RTnet rt2500 driver
- low-level real-time WLAN hacking...

Cheers,
Jan
