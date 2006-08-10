Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWHJUC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWHJUC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWHJUBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:01:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:24977 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932669AbWHJT7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:59:35 -0400
Date: Thu, 10 Aug 2006 21:59:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: [NTP 8/9] convert to the NTP4 reference model
In-Reply-To: <20060810122905.b8dd7104.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0608102139410.6761@scrub.home>
References: <20060810000146.913645000@linux-m68k.org> <20060810001115.525351000@linux-m68k.org>
 <20060810114903.089825bc.akpm@osdl.org> <Pine.LNX.4.64.0608102106180.6761@scrub.home>
 <20060810122905.b8dd7104.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Andrew Morton wrote:

> > It's the behaviour the current ntp daemon expects, the ntp documentation 
> > has more information and a link to the package (e.g. under Debian at 
> > /usr/share/doc/ntp-doc/html/kern.html).
> > 
> 
> So...  the current kernel is behaving in a manner other than that which the
> NTP daemon expects?  Does this cause any problems?

It's not drastically different, so for normal internet usage there is no 
big difference.
http://www.ntp.org/ntpfaq/NTP-s-compat.htm has a bit more information on 
this topic.

> I'm trying to work out what reason we might have for merging this patch.

It also allows us to sanely readd the PPS bits, where the changes were 
more significant.

bye, Roman
