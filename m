Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161542AbWAMK0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161542AbWAMK0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWAMK0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:26:44 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19629 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161542AbWAMK0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:26:43 -0500
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, Jon Mason <jdmason@us.ibm.com>,
       Muli Ben-Yehuda <mulix@mulix.org>, Jiri Slaby <slaby@liberouter.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1137105731.2370.94.camel@mindpipe>
References: <20060112175051.GA17539@us.ibm.com>
	 <43C6ADDE.5060904@liberouter.org>
	 <20060112200735.GD5399@granada.merseine.nu>
	 <20060112214719.GE17539@us.ibm.com>  <20060112220039.GX29663@stusta.de>
	 <1137105731.2370.94.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Jan 2006 10:28:22 +0000
Message-Id: <1137148102.3645.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-12 at 17:42 -0500, Lee Revell wrote:
> OK I set that bug to FEEDBACK, but it's open 5 months now and no testers
> are forthcoming.  I think if we don't find one as a result of this
> thread we can assume no one cares about this hardware anymore.

Nobody reads ALSA bugzilla. You are probably right but its not clear,
and if the audio is going the video component might as well go too.

Have you checked with the ARM people or the person who added support (
pwaechtler@loewe-komp.de) ?

It's also used in various appliances people "adjust" to run Linux - the
Philips AOL-TV for example. Also on the SH reference boards for the
hitachi sh series cpus (arch/sh*).

> I think the best approach might just be to drop it in lieu of a tester.
> It will be trivial to add support later if someone finds one of these
> boxes.

Think it should stay for now at least. Pointing at ALSA bugzilla as
proof of non-use is not a good test.

Alan
