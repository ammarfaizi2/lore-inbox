Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVC2TFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVC2TFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVC2TFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:05:15 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:28640 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261301AbVC2TFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:05:10 -0500
Subject: Re: Mac mini sound woes
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Takashi Iwai <tiwai@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1112094290.6577.19.camel@gaston>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe>  <s5h8y46kbx7.wl@alsa2.suse.de>
	 <1112094290.6577.19.camel@gaston>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 14:05:08 -0500
Message-Id: <1112123109.4922.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 21:04 +1000, Benjamin Herrenschmidt wrote:
> Can the driver advertize in some way what it can do ? depending on the
> machine we are running on, it will or will not be able to do HW volume
> control... You probably don't want to use softvol in the former case...
> 
> dmix by default would be nice though :)

No, there's still no way to ask the driver whether hardware mixing is
supported yet.  It's come up on alsa-devel before.  Patches are welcome.

dmix by default would not be nice as users who have sound cards that can
do hardware mixing would be annoyed.  However, in the upcoming 1.0.9
release softvol will be used by default for all the mobo chipsets.

Lee

