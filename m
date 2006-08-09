Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWHIUlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWHIUlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWHIUlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:41:35 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:57514 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751359AbWHIUle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:41:34 -0400
Subject: Re: ALSA problems with 2.6.18-rc3
From: Lee Revell <rlrevell@joe-job.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Andrew Benton <b3nt@ukonline.co.uk>,
       Takashi Iwai <tiwai@suse.de>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <200608091417.55431.gene.heskett@verizon.net>
References: <44D8F3E5.5020508@ukonline.co.uk>
	 <44DA0D93.2080307@ukonline.co.uk> <1155141333.26338.186.camel@mindpipe>
	 <200608091417.55431.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 16:41:29 -0400
Message-Id: <1155156090.26338.193.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 14:17 -0400, Gene Heskett wrote:
> On Wednesday 09 August 2006 12:35, Lee Revell wrote:
> >On Wed, 2006-08-09 at 17:30 +0100, Andrew Benton wrote:
> >> Lee Revell wrote:
> >> > Please try to identify the change that introduced the regression. 
> >> > What was the last kernel/ALSA version that worked correctly?
> >>
> >> The change happened between 2.6.17 and 2.6.18-rc1. Specifically,
> >> 2.6.17-git4 works and 2.6.17-git5 doesn't.
> >
> >Takashi-san,
> >
> >Does this help at all?  Many users are reporting that sound broke with
> >2.6.18-rc*.
> >
> >Lee
> >
> Takashi-san's suggestion earlier today of running an "alsactl -F restore" 
> seems to have fixed all those diffs right up, I now have good sound with 
> an emu10k1 using an audigy 2 as card-0, running kernel-2.6.18-rc4.

Distros should probably be using this as a default.  Otherwise, simply
adding a new mixer control will cause restoring mixer settings to fail.

Lee

