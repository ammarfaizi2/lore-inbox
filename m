Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWAUV4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWAUV4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWAUV4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:56:40 -0500
Received: from mercury.sdinet.de ([193.103.161.30]:34184 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S932398AbWAUV4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:56:40 -0500
Date: Sat, 21 Jan 2006 22:56:38 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Michael Loftis <mloftis@wgops.com>,
       Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Development tree, PLEASE?
In-Reply-To: <1137829140.3241.141.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com> 
 <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com> <1137829140.3241.141.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jan 2006, Lee Revell wrote:

> On Sat, 2006-01-21 at 00:22 -0700, Michael Loftis wrote:
>> It makes maintenance a real nightmare
>> for atleast one environment in which I maintain production systems
>
> Why do you keep having to upgrade the kernel on production systems, if
> the old kernel does what you need?

But it is missing all security updates.

What I am currently doing to workaround this problem:

- using Debian Sarge on my production servers as a base
   (good packages, but kernel is just too old)
- Kernel 2.6.12 from Ubuntu Breezy (taken as source, not binary packages)

This way I have at least a working kernel (2.6.8 does not work on my newer 
boxes) and the security updates from Ubuntu, getting kernel updates with 
only little changes and low update-risks.

Mainstream kernel is just unusable when you don't have the time to verify
the lots of changes in production environments.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
