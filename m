Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWC3HgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWC3HgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWC3HgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:36:14 -0500
Received: from wproxy.gmail.com ([64.233.184.237]:30044 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751296AbWC3HgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:36:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=XVo9zO7MeeehEnn/cErGtZIABcvqw2nxeQkjmu6MPiObxQ0/vOPfxZ+RFHc/47SBz6cR1C826tqqsfrb03fuWmNCkDp1KNrn987sH8Vy8MjrBn2QiwVlmTmvfRJx56iM1DhnmmoO3olJPIwMzk5erQ+SXq0t8yplqHDOHK2Lkbs=
Date: Thu, 30 Mar 2006 09:36:05 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2] Kconfig SND_SEQUENCER_OSS help text fix
Message-ID: <20060330073605.GA10311@silenus.home.res>
References: <20060328003508.2b79c050.akpm@osdl.org> <20060328134654.GA9671@silenus.home.res> <1143617782.442a38f61b98b@www.domainfactory-webmail.de> <20060329094419.GA9446@silenus.home.res> <s5hacb9kt96.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hacb9kt96.wl%tiwai@suse.de>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 09:20:21PM +0200, Takashi Iwai wrote:
> Please fix the module name to snd-seq-oss ?
> 
> Otherwise it looks fine.
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>
 
Oops, here it is:

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- linux-2.6.16-mm2/sound/core/Kconfig~	2006-03-29 11:08:33.000000000 +0200
+++ linux-2.6.16-mm2/sound/core/Kconfig	2006-03-29 11:27:23.000000000 +0200
@@ -92,8 +92,9 @@
 
 	  Many programs still use the OSS API, so say Y.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called snd-seq-oss.
+	  If you choosed M in "Sequencer support" (SND_SEQUENCER),
+	  this will be compiled as a module. The module will be called
+	  snd-seq-oss.
 
 config SND_RTCTIMER
 	tristate "RTC Timer support"
