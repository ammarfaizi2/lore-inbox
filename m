Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWJQV74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWJQV74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWJQV74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:59:56 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:32528 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1750752AbWJQV7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:59:55 -0400
Date: Tue, 17 Oct 2006 17:59:47 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] Restore sysctl syscall option for non-embedded users
In-Reply-To: <1161123096.5014.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610171753270.32343@lancer.cnet.absolutedigital.net>
References: <453519EE.76E4.0078.0@novell.com>  <20061017091901.7193312a.rdunlap@xenotime.net>
  <Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
 <1161123096.5014.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006, Alan Cox wrote:

> Ar Maw, 2006-10-17 am 14:17 -0400, ysgrifennodd Cal Peake:
> > My dmesg gets spammed to all hell with these warnings. Can we keep this 
> > option easily visible till it gets ripped out Jan of 2007 (see 
> > Documentation/feature-removal-schedule.txt for reference)?
> 
> NAK
> 
> The problem is that this option is available at all. Deprecating
> syscalls especially trivial ones is fundamentally wrong. The correct fix
> is to make sysctl always present except as an option for embedded and
> not to deprecate it.

Works for me. If everyone agrees I'll whip up a patch to match Alan's 
description and remove the deprecation notice.

thanks,

  - C.

-- 
"There is nothing wrong with your television set. Do not attempt
    to adjust the picture. We are controlling transmission."
                    -- The Outer Limits

