Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVC2LGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVC2LGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVC2LGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:06:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:2780 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262360AbVC2LFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:05:49 -0500
Subject: Re: Mac mini sound woes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <s5h8y46kbx7.wl@alsa2.suse.de>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe>  <s5h8y46kbx7.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 21:04:50 +1000
Message-Id: <1112094290.6577.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes.
> 
> > dmix has been around for a while but softvol plugin is very new, you
> > will need ALSA CVS or the upcoming 1.0.9 release.
> 
> dmix currently doesn't work on PPC well but I'll fix it soon later.
> If it's confirmed to work, we can set dmix/softvol plugins for default
> of snd-powermac driver configuration.  Hopefully this will be finished
> before 1.0.9 final.

Can the driver advertize in some way what it can do ? depending on the
machine we are running on, it will or will not be able to do HW volume
control... You probably don't want to use softvol in the former case...

dmix by default would be nice though :)

Ben.

