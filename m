Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSHBNs5>; Fri, 2 Aug 2002 09:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSHBNs4>; Fri, 2 Aug 2002 09:48:56 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:50836 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S313563AbSHBNsD>; Fri, 2 Aug 2002 09:48:03 -0400
Date: Fri, 2 Aug 2002 16:52:04 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: ATAPI CD-R lags system to hell burning in DAO mode; but not in TAO
Message-ID: <20020802135204.GA23988@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	linux-kernel@vger.kernel.org
References: <20020731203008.GA27702@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731203008.GA27702@vitelus.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 01:30:08PM -0700, Aaron Lehmann wrote:
> I've got a Teac CD-W524E 24x CD-R writer, and ever since I got it
> several months ago I have had the somewhat annoying issue that burning
> a cd Disc-At-Once makes the system unusable during the burn. The X
> cursor jerks, repaints take forever, etc. This problem doesn't occur
> when burning Track-At-Once - I'm unable to notice any significant
> increase in system latency when using that mode.
 
I've been having a similar problem, but in my case it's audio and other
non-data CD writes like VCD that have this kind of slowdown problem.
DAO vs. TAO doesn't matter in my case. IDE chipset is VIA 686b. The
problem disappears if I plug the writer to onboard pdc20265, but burns
on that are otherwise flaky.
