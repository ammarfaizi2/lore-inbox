Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVABWij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVABWij (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 17:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVABWii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 17:38:38 -0500
Received: from mail.tmr.com ([216.238.38.203]:37833 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261176AbVABWig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 17:38:36 -0500
Message-ID: <41D87A64.1070207@tmr.com>
Date: Sun, 02 Jan 2005 17:49:08 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: William Lee Irwin III <wli@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <20050102214211.GM29332@holomorphy.com><20050102214211.GM29332@holomorphy.com> <20050102221534.GG4183@stusta.de>
In-Reply-To: <20050102221534.GG4183@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Jan 02, 2005 at 01:42:11PM -0800, William Lee Irwin III wrote:
> 
>>This is not optimism. This is experience. Every ``stable'' kernel I've
>>seen is a pile of incredibly stale code where vi'ing any file in it
>>instantly reveals numerous months or years old bugs fixed upstream.
>>What is gained in terms of reducing the risk of regressions is more
>>than lost by the loss of critical examination and by a long longshot.
> 
> 
> The main advantage with stable kernels in the good old days (tm) when 4 
> and 6 were even numbers was that you knew if something didn't work, and 
> upgrading to a new kernel inside this stable kernel series had a 
> relatively low risk of new breakages. This meant one big migration every 
> few years and relatively easy upgrades between stable series kernels.
> 
> Nowadays in 2.6, every new 2.6 kernel has several regressions compared 
> to the previous one, and additionally obsolete but used code like 
> ipchains and devfs is scheduled for removal making upgrades even harder 
> for many users.

And there you have my largest complaint with the new model. If 2.6 is 
stable, it should not have existing features removed just because 
someone has a new wet dream about a better but incompatible way to do 
things. I expect working programs to be deliberately broken in a 
development tree, but once existing features are removed there simply is 
no stable set of features.
> 
> There's the point that most users should use distribution kernels, but 
> consider e.g. that there are poor souls with new hardware not supported 
> by the 3 years old 2.4.18 kernel in the stable part of your Debian 
> distribution.

The stable and development kernel model worked for a decade, partly 
because people could build on a feature set and not have that feature 
just go away, leaving the choice of running without fixes or not 
running. Since we manage to support 2.2 and 2.4 (and perhaps even 2.0?) 
I don't see why the definition of "stable" can't simply mean "no 
deletions from the feature set" and let new features come in for those 
who want them. Absent that 2.4 will be the last stable kernel, in the 
sense that features won't be deliberately broken or removed.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
