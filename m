Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVFEUzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVFEUzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVFEUzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 16:55:50 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44191 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261616AbVFEUzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 16:55:45 -0400
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
From: Lee Revell <rlrevell@joe-job.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <200506051015.33723.kernel-stuff@comcast.net>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
	 <200506041440.09795.kernel-stuff@comcast.net>
	 <20050605112840.GX23831@wotan.suse.de>
	 <200506051015.33723.kernel-stuff@comcast.net>
Content-Type: text/plain
Date: Sun, 05 Jun 2005 16:51:21 -0400
Message-Id: <1118004681.20910.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-05 at 10:15 -0400, Parag Warudkar wrote:
> > Also note that pmtimer does not even drive the timer interrupt,
> > just gettimeofday.
> 
> Could it be that the music players use gettimeofday() for time keeping? Sure 
> enough they are broken with -rc5.

Well, that would be a broken design anyway.  That's what the ALSA timer
API is for.  But XMMS has a long history of buggy ALSA support anyway.

Do you get the same result with native OSS, ALSA OSS emulation, and
native ALSA?

Lee

