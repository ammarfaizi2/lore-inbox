Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSKYKrd>; Mon, 25 Nov 2002 05:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSKYKrd>; Mon, 25 Nov 2002 05:47:33 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:7652 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262838AbSKYKrc>;
	Mon, 25 Nov 2002 05:47:32 -0500
Date: Mon, 25 Nov 2002 11:54:46 +0100
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: [Benchmark] AIM results
Message-ID: <20021125105446.GA30842@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@digeo.com>,
	Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20021124212337.30844.qmail@linuxmail.org> <3DE1FF62.18F7071B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DE1FF62.18F7071B@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 02:45:54AM -0800, Andrew Morton wrote:


> > tcp_test 10000 805.5        72495.00 TCP/IP Messages/second
> > tcp_test 10000 660.7        59463.00 TCP/IP Messages/second
> > ^^^^^ Here 2.4.19 is faster then 2.5.49 (debug?)
> > 
> > udp_test 10000 1448.6       144860.00 UDP/IP DataGrams/second
> > udp_test 10000 1115.7       111570.00 UDP/IP DataGrams/second
> > ^^^^^ Here 2.4.19 is faster then 2.5.49 (debug?)
> 
> Not sure what's going on here, really.  Lots of tiny TCP and UDP
> copies to localhost.  The profiles are splattered all over the place.
> Networking just generally seems to have increased its cache footprint.

Dave has said there is debugging code in 2.5 that slows down traffic on
localhost.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
