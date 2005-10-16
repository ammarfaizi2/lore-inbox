Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVJPRH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVJPRH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 13:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVJPRH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 13:07:26 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:44264 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1751333AbVJPRHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 13:07:25 -0400
Date: Sun, 16 Oct 2005 20:07:18 +0300
From: Ville Herva <vherva@vianova.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc4: broken DVD-R recording [Re: Upgrade 2.6.12-rc4 -> 2.6.13.1 broke DVD-R writing (fails consistently in OPC phase)]
Message-ID: <20051016170718.GK24760@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20050925123049.GA24760@viasys.com> <43369C2F.3050201@telia.com> <20050925130436.GD24719@viasys.com> <20050925142825.GB24742@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050925142825.GB24742@viasys.com>
X-Operating-System: Linux herkules.vianova.fi 2.4.27
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2005 at 05:28:25PM +0300, you [Ville Herva] wrote:
> On Sun, Sep 25, 2005 at 04:04:36PM +0300, you [Ville Herva] wrote:
> > On Sun, Sep 25, 2005 at 02:46:39PM +0200, you [Simon Strandman] wrote:
> > > Ville Herva skrev:
> > > 
> > > >The .config from 2.6.12-rc4 and 2.6.13.1 is nearly identical, but with
> > > >2.6.13.1 I use HZ=250 (that being the default nowadays) and 
> > > >2.6.13.1 has CONFIG_PREEMPT_VOLUNTARY=y instead of 2.6.12-rc4's
> > > >CONFIG_PREEMPT=y and CONFIG_PREEMPT_BKL=y �.
> > > >
> > > >Any ideas?
> > >
> > > Have you tried with HZ=1000?
> > 
> > No yet. 
> > 
> > I did see the HZ=250 problem wrt DVD recording thread earlier, but I got the
> > impression it had to do with not being able to supply data fast enough to
> > the drive. 
> > 
> > In my case, it fails before it even write a single byte to the disc.
> > (Fortunately it means it doesn't ruin the disc each time I try to write.)
> 
> Recompiled the same 2.6.13.1 kernel with HZ=1000. DVD-R writing still fails
> with the exact same error.

Still happens with 2.6.14-rc4.

Peter �sterlund's suggestion to kill hald and kded in the pktcdvd thread did
not help either. This is a Fedora rawhide installation, though.



-- v -- 

v@iki.fi

