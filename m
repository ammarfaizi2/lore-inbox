Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293742AbSB1Uuh>; Thu, 28 Feb 2002 15:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293720AbSB1Usk>; Thu, 28 Feb 2002 15:48:40 -0500
Received: from ns.suse.de ([213.95.15.193]:34320 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293732AbSB1Upz>;
	Thu, 28 Feb 2002 15:45:55 -0500
Date: Thu, 28 Feb 2002 21:45:52 +0100
From: Dave Jones <davej@suse.de>
To: Nathan Walp <faceprint@faceprint.com>
Cc: Benjamin Pharr <ben@benpharr.com>, linux-kernel@vger.kernel.org,
        manfred@colorfullife.com
Message-ID: <20020228214552.F32662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nathan Walp <faceprint@faceprint.com>,
	Benjamin Pharr <ben@benpharr.com>, linux-kernel@vger.kernel.org,
	manfred@colorfullife.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

manfred@colorfullife.com	
Bcc: 
Subject: Re: Linux 2.5.5-dj1 - Bug Reports
Reply-To: 
In-Reply-To: <20020228165951.GA4014@faceprint.com>; from faceprint@faceprint.com on Thu, Feb 28, 2002 at 11:59:54AM -0500

 > > On Fri, Feb 22, 2002 at 02:21:49AM +0100, Dave Jones wrote:
 > > >  > It compiled fine. When I booted up everything looked normal with the
 > > >  > exception of a 
 > > >  > eth1: going OOM 
 > > >  > message that kept scrolling down the screen. My eth1 is a natsemi card.
 > > > 
 > > >  That's interesting. Probably moreso for Manfred. I'll double check
 > > >  I didn't goof merging the oom-handling patch tomorrow.
 > > 
 > > Ditto here on my natsemi.  It hasn't really spit out the error since
 > > boot, about 12 hours ago.  Card has been mainly idle, only used to
 > > connect via crossover cable to my laptop, which hasn't been used much in
 > > that time.
 > 
 > dj2 is showing the same behavior, but I found out that the messages
 > continue to be printed 100 times/second until I ping-flooded the machine
 > on the other end of that card.  The minimal DHCP traffic prior to the
 > ping flood was not enough to make it stop.
 > 
 > Hope this helps narrow down the problem some.

 Yup, Manfred is aware of this, but hasn't had time to look into it yet.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
