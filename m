Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132850AbRDQTmk>; Tue, 17 Apr 2001 15:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132845AbRDQTmO>; Tue, 17 Apr 2001 15:42:14 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:26123 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132851AbRDQTlm>;
	Tue, 17 Apr 2001 15:41:42 -0400
Date: Tue, 17 Apr 2001 21:41:23 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: george anzinger <george@mvista.com>
Cc: Mark Salisbury <mbs@mc.com>, Ben Greear <greearb@candelatech.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
Message-ID: <20010417214123.B25583@pcep-jamie.cern.ch>
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <0104160841431V.01893@pc-eng24.mc.com> <3ADB45C0.E3F32257@mvista.com> <01041710225227.01893@pc-eng24.mc.com> <3ADC912A.B497B724@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ADC912A.B497B724@mvista.com>; from george@mvista.com on Tue, Apr 17, 2001 at 11:53:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> > > a.) list insertion of an arbitrary timer,
> > should be O(log(n)) at worst
> > 
> > > b.) removal of canceled and expired timers, and
> > easy to make O(1)
> 
> I thought this was true also, but the priority heap structure that has
> been discussed here has a O(log(n)) removal time.

Several priority queue structures support removal in O(1) time.
Perhaps you are thinking of the classic array-based heap, for
which removal is O(log n) in the general case.

-- Jamie
