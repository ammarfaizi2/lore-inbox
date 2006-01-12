Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161391AbWALWzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391AbWALWzr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161395AbWALWzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:55:47 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:56799 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161391AbWALWzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:55:46 -0500
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060112225205.GZ29663@stusta.de>
References: <20060112175051.GA17539@us.ibm.com>
	 <43C6ADDE.5060904@liberouter.org>
	 <20060112200735.GD5399@granada.merseine.nu>
	 <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de>
	 <1137105731.2370.94.camel@mindpipe>  <20060112225205.GZ29663@stusta.de>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 17:55:44 -0500
Message-Id: <1137106544.2370.97.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 23:52 +0100, Adrian Bunk wrote:
> > I'm still not sure that just adding it to the ALSA driver and hoping it
> > works is the best solution.  Would we rather users see right away that
> > their hardware isn't supported, or have the driver load and get no sound
> > or hang the machine?
> > 
> > I think the best approach might just be to drop it in lieu of a tester.
> > It will be trivial to add support later if someone finds one of these
> > boxes.
> 
> Agreed.
> 

OK I'm just going to close that bug, the one person who seemed to know
anything about it had this to say:

"The cyberpro 5050 is an old combined video+audio controller - and
is/was used in some settop boxes (German Siemens Activity and also
Loewe).

There will be no "desktop users" around.
And because I don't work for Loewe anymore: I don't have access to
hardware.

If you ask me: leave it out!"

Anyone who finds one of these is free to reopen it.

Lee

