Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282896AbRLLXkr>; Wed, 12 Dec 2001 18:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282890AbRLLXki>; Wed, 12 Dec 2001 18:40:38 -0500
Received: from [209.249.147.248] ([209.249.147.248]:15116 "EHLO
	proxy1.addr.com") by vger.kernel.org with ESMTP id <S282896AbRLLXkY>;
	Wed, 12 Dec 2001 18:40:24 -0500
Date: Wed, 12 Dec 2001 18:38:43 -0500
From: Daniel Gryniewicz <dang@fprintf.net>
To: Alp ATICI <atici@math.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Network related
Message-Id: <20011212183843.3db1580b.dang@fprintf.net>
In-Reply-To: <Pine.LNX.4.40.0112121821260.4894-100000@intel4.math.columbia.edu>
In-Reply-To: <Pine.LNX.4.40.0112121821260.4894-100000@intel4.math.columbia.edu>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My guess is that this is becuase you have IPv6 turned on, and these sites
resolve to an IPv6 address, as well as an IPv4 address.  Linux will not, under
these circumstances, fall back on the IPv4 address.  Turn of IPv6, or connect
to the 6bone.

Daniel

On Wed, 12 Dec 2001 18:29:17 -0500 (EST)
Alp ATICI <atici@math.columbia.edu> wrote:

> Hi,
> I have a problem with the 2.4.14 kernel custom compiled on a RedHat 7.2. I
> thought I was very careful in selecting the necessary modules at first.
> Everything works great except that when I want to browse some sites
> I get a "connection timed out". Most of the sites work ok but some
> specific ones like www.nvidia.com, www.sun.com, www.ingdirect.com
> never works and gives the same error. When I boot up with other
> kernel or win2000 everything works fine though:( Maybe this is
> a consequence of some other bigger problem which I couldn't figure
> out so far. It looks like only those sites filter out my http request.
> What modules could I have forgotten to include?
> 
> Another question is I don't have ipt_MIRROR, ipt_unclean, ipt_iplimit
> in netfilter modules anymore. What config settings should I set on
> to have these back?
> Thanks a lot,
> Alp


--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

