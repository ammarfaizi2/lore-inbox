Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSKEPtY>; Tue, 5 Nov 2002 10:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSKEPtY>; Tue, 5 Nov 2002 10:49:24 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:62352 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264877AbSKEPtX>;
	Tue, 5 Nov 2002 10:49:23 -0500
Date: Tue, 5 Nov 2002 16:55:59 +0100
From: bert hubert <ahu@ds9a.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: naive but spectacular ext3 HTREE+Orlov benchmark
Message-ID: <20021105155559.GA6765@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	tytso@mit.edu
References: <20021105151702.GA5894@outpost.ds9a.nl> <1036512604.4827.93.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036512604.4827.93.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 04:10:04PM +0000, Alan Cox wrote:
> On Tue, 2002-11-05 at 15:17, bert hubert wrote:
> > Congratulations everybody, this is a major result! You can in fact *hear*
> > the difference. With the Orlov allocator, seeks are much more higher pitched
> > as if they are generally over shorter distances - which they probably are.
> 
> How does the Orlov allocator do if you continually randomly use and
> reuse the file space for a long period of time - the current allocator
> is pretty stable, does Orlov behave the same or degenerate ?

This fs is in daily use, I'll keep an eye on it and rerun the benchmark
above every once in a while. Luckily 2.5 is stable enough for me to run on
my main computer.

Although all my important stuff lives in cvs anyhow.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
