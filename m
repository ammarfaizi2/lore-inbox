Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWC3Lvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWC3Lvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWC3Lvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:51:53 -0500
Received: from wproxy.gmail.com ([64.233.184.224]:3463 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751127AbWC3Lvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:51:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=nqHo7g5ciIvfQhE5nhGntgSxpS9e8juPaHv9ylzw87zXcF71J6FLxHo8whDOuK0T0ivqkbLlJuC9tlhWhG++rORPP37+z1370d/7orUJSe7on/0h64vx6Ptt8G5tjMP0Nc8JN2eblAZjO4sFKwYt78E2bG47n/Ao2ZFMmCKvIBc=
Date: Thu, 30 Mar 2006 13:51:45 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2] Kconfig SND_SEQUENCER_OSS help text fix
Message-ID: <20060330115145.GB10311@silenus.home.res>
References: <20060328003508.2b79c050.akpm@osdl.org> <20060328134654.GA9671@silenus.home.res> <1143617782.442a38f61b98b@www.domainfactory-webmail.de> <20060329094419.GA9446@silenus.home.res> <s5hacb9kt96.wl%tiwai@suse.de> <20060330073605.GA10311@silenus.home.res> <442BA30C.70606@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442BA30C.70606@keyaccess.nl>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 12:21:16PM +0200, Rene Herman wrote:
> Frederik Deweerdt wrote:
> 
> >+	  If you choosed M in "Sequencer support" (SND_SEQUENCER),
> 
> "choosed" is not English. Present tense "choose", past tense "chose".
> 
> Rene.
Thanks, here's the corrected version.

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- linux-2.6.16-mm2/sound/core/Kconfig~	2006-03-29 11:08:33.000000000 +0200
+++ linux-2.6.16-mm2/sound/core/Kconfig	2006-03-29 11:27:23.000000000 +0200
@@ -92,8 +92,9 @@
 
 	  Many programs still use the OSS API, so say Y.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called snd-seq-oss.
+	  If you choose M in "Sequencer support" (SND_SEQUENCER),
+	  this will be compiled as a module. The module will be called
+	  snd-seq-oss.
 
 config SND_RTCTIMER
 	tristate "RTC Timer support"
