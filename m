Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269637AbUHZU7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269637AbUHZU7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269664AbUHZU5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:57:24 -0400
Received: from holomorphy.com ([207.189.100.168]:41880 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269590AbUHZUiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:38:11 -0400
Date: Thu, 26 Aug 2004 13:38:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jmerkey@comcast.net
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-ID: <20040826203806.GH2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jmerkey@comcast.net, Roland Dreier <roland@topspin.com>,
	linux-kernel@vger.kernel.org, jmerkey@drdos.com
References: <082620042024.23755.412E47050006895C00005CCB2200751150970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <082620042024.23755.412E47050006895C00005CCB2200751150970A059D0A0306@comcast.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was stripped from:
>> Though asinine, the ABI spec is set in stone.

On Thu, Aug 26, 2004 at 08:24:38PM +0000, jmerkey@comcast.net wrote:
> Why should Linux, which supports multiple executable formats, tie
> itself to ELF exclusively? I doubt I am going to need to run ORACLE
> or some other piggish app on my embedded linux system, but I would
> like to have more kernel address space for drivers and other
> appliance type features.  What do you plan to do when the driver base
> becomes as large as the one in WIndows 2000/XP and you don't have
> enough memory to load all the drivers.  Right now, iptables barfs
> even with 3GB of address space when you load up about a  dozen
> virtual network interfaces ?  Microsoft had this same problem (only
> at a much sooner juncture in their platform evolution) and went to
> VM support in the kernel itself to increase virtual address space for
> kernel apps, file systems, and drivers when thye hit the wall. It's
> coming time to start thinking about it.  

You're years late to this game. It's been thought about and the
consensus (which I disagreed with) was to reject virtualspace pressure
related changes of this kind for 32-bit platforms in favor of refusing
to support 32-bit platforms and/or workloads requiring them.

Also, please line wrap at 80 characters (preferably 70) and please
don't top post. The request about "top posting" is that placing quoted
text prior to your responses in the message, with a line attributing the
quoted text to the original author immediately above the quoted text is
greatly preferred over the quoting arrangements made in your post(s).


-- wli
