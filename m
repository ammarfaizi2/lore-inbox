Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTBCQJk>; Mon, 3 Feb 2003 11:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTBCQJk>; Mon, 3 Feb 2003 11:09:40 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:6581 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S266796AbTBCQJj>;
	Mon, 3 Feb 2003 11:09:39 -0500
Date: Mon, 3 Feb 2003 17:19:10 +0100
From: bert hubert <ahu@ds9a.nl>
To: John Bradford <john@grabjohn.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, davem@redhat.com,
       greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: problems achieving decent throughput with latency.
Message-ID: <20030203161910.GA13371@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	John Bradford <john@grabjohn.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>, davem@redhat.com,
	greearb@candelatech.com, linux-kernel@vger.kernel.org
References: <3E3E8CAC.7010807@nortelnetworks.com> <200302031611.h13GBl9D019119@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302031611.h13GBl9D019119@darkstar.example.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 04:11:46PM +0000, John Bradford wrote:
> > > TCP can only send into a pipe as fast as it can see the
> > > ACKs coming back.  That is how TCP clocks its sending rate,
> > > and latency thus affects that.
> > 
> > Wouldn't you just need larger windows?  The problem is latency, not 
> > bandwidth.
> 
> Exactly - the original post says that no problems are experienced
> using UDP, which backs that up.

My TCP may be getting hazy but with latency, TCP may limit the amount of
packets 'in flight'. I think this is called the 'cwnd', congestion window. I
also seem to recall that this window is limited to the actually negotiated
TCP window size.

But here I leave this discussion as I've swapped out the finer details of
congestion windows to the Stevens books which other's have probably read
more recently than I did.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
