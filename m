Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWFZS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWFZS2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWFZS2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:28:36 -0400
Received: from mx1.suse.de ([195.135.220.2]:49287 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932624AbWFZS2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:28:35 -0400
From: Andi Kleen <ak@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Alsa update in mainline broke ATI-IXP sound driver II
Date: Mon, 26 Jun 2006 20:28:31 +0200
User-Agent: KMail/1.9.3
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <200606252139.36002.ak@suse.de> <200606261845.32450.ak@suse.de> <s5hr71b95q7.wl%tiwai@suse.de>
In-Reply-To: <s5hr71b95q7.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606262028.31807.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, and still you get the same error like:
> 
> 	ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
> 	...
> ??

Yes.

> Any change if you set CONFIG_SND_DYNAMIC_MINORS=y ?

With that it finally works. Thanks.

Still can it be fixed?

-Andi

