Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVFEVqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVFEVqn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 17:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVFEVqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 17:46:43 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:5592 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261606AbVFEVql convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 17:46:41 -0400
X-Comment: AT&T Maillennium special handling code - c
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Date: Sun, 5 Jun 2005 17:41:45 -0400
User-Agent: KMail/1.8
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
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506051015.33723.kernel-stuff@comcast.net> <1118004681.20910.2.camel@mindpipe>
In-Reply-To: <1118004681.20910.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506051741.46479.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 June 2005 16:51, Lee Revell wrote:
> Well, that would be a broken design anyway.  That's what the ALSA timer
> API is for.  But XMMS has a long history of buggy ALSA support anyway.
>

I am not sure they use gettimeofday(). Pardon my ignorance but why is it 
broken for them to use gettimeofday()?

> Do you get the same result with native OSS, ALSA OSS emulation, and
> native ALSA?

I am not sure about OSS and ALSA OSS emulation but I tried XMMS with ALSA 
output plugin and Juk and amaroK with GStreamer/alsasink. All of them have 
the same problem.

Parag
