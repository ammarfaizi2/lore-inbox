Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274635AbRITUk1>; Thu, 20 Sep 2001 16:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274638AbRITUkS>; Thu, 20 Sep 2001 16:40:18 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:60685 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S274635AbRITUkE>; Thu, 20 Sep 2001 16:40:04 -0400
Message-ID: <3BAA53BA.524A3622@osdlab.org>
Date: Thu, 20 Sep 2001 13:38:18 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Andrea Arcangeli <andrea@suse.de>,
        "Dieter =?iso-8859-1?Q?N=FCtzel?=" <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>, Roger Larsson <roger.larsson@norran.net>,
        linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <1000939458.3853.17.camel@phantasy> <20010920063143.424BD1E41A@Cantor.suse.de> <20010920084131.C1629@athlon.random> <20010920075751.6CA791E6B2@Cantor.suse.de> <20010920102139.G729@athlon.random> <3BAA4DD2.FDDAEE6F@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Andrea Arcangeli wrote:
> >
> > those are kernel addresses, can you resolve them via System.map rather
> > than trying to find their start/end line number?
> 
> Uh, trying to find???  These are the names and line numbers provided by
> the PPC macros.  The only time the address is helpful is when the bad
> guy is hiding in an "inline" in a header file.  Still, is there a simple
> script to get the function/offset from the System.map?  We could then
> post process with a simple bash/sed script.

I posted one earlier today (Perl).  It's at
http://www.osdlab.org/sw_resources/scripts/ksysmap .

~Randy
