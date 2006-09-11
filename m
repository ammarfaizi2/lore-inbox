Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWIKWvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWIKWvV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIKWvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:51:21 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56519 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751009AbWIKWvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:51:20 -0400
Subject: Re: 2.6.18-rc6-mm1: endless loop in snd_hda_intel on HPC 6325,
	sometimes
From: Lee Revell <rlrevell@joe-job.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
In-Reply-To: <200609112220.04753.rjw@sisk.pl>
References: <200609112220.04753.rjw@sisk.pl>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 18:52:00 -0400
Message-Id: <1158015120.5076.228.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 22:20 +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On the HPC 6325 I'm currently using snd_hda_intel sometimes goes into an
> endless loop in wich it plays the same chunk of sound (< 1 sec.) repeatedly
> forever.
> 
> It helps to reload the snd_hda_intel module.
> 

Does position_fix help?  See
Documentation/sound/alsa/ALSA-Configuration.txt.

Lee

