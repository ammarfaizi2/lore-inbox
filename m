Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWAEWBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWAEWBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWAEWBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:01:20 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15054 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750903AbWAEWBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:01:20 -0500
Subject: Re: No Coax digital out with SB Live! and 2.6.15
From: Lee Revell <rlrevell@joe-job.com>
To: Tino Keitel <tino.keitel@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060104073617.GA15342@localhost.localdomain>
References: <20060103180831.GA5265@localhost.localdomain>
	 <20060104072618.GA10973@localhost.localdomain>
	 <20060104073617.GA15342@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 17:01:17 -0500
Message-Id: <1136498477.847.52.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 08:36 +0100, Tino Keitel wrote:
> On Wed, Jan 04, 2006 at 08:26:18 +0100, Tino Keitel wrote:
> > On Tue, Jan 03, 2006 at 19:08:31 +0100, Tino Keitel wrote:
> > > Hi folks,
> > > 
> > > since I upgraded to 2.6.15, the Coax digital output of my SB Live!
> > > stays silent. Analog output works. After reverting to 2.6.14.3 the
> > > digital output works again. Does anyone have a solution for this or at
> > > least the same problem?
> > 
> > I just tried alsa-driver 1.0.11-rc2 and now the digital out works again.
> 
> alsa-driver 1.0.10 works, too.

Are you sure it was not a mixer settings issue?

If you can confirm that this is a regression try to narrow it down by
code inspection or binary search by date with ALSA CVS it can be fixed
for 2.6.15.x.

Lee

