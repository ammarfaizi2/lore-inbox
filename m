Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVKYMzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVKYMzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 07:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbVKYMzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 07:55:13 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15630 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932434AbVKYMzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 07:55:11 -0500
To: Douglas J Hunley <doug@hunley.homeip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stupid question about netlink and 2.6.14 and latest udev
References: <200511231529.55683.doug@hunley.homeip.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: the definitive fritterware.
Date: Fri, 25 Nov 2005 12:54:34 +0000
In-Reply-To: <200511231529.55683.doug@hunley.homeip.net> (Douglas J.
 Hunley's message of "23 Nov 2005 20:36:16 -0000")
Message-ID: <87hda0lwfp.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Nov 2005, Douglas J. Hunley said:
> Latest udev says that it requires netlink support in the kernel, however I 
> can't find any concrete info on how to enable netlink in 2.6.14+ .. a grep of 
> NETLINK in .config doesn't find anything. I saw an option that made reference 
> to netlink, but it didn't actually state that it was enabling netlink. What's 
> the magic config option? Or how does one check if a running kernel has 
> netlink support functional?

If you have network support at all (i.e. CONFIG_NET=y), you have netlink
support. (This has been true for some time.)

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell

