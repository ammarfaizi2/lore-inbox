Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWDEVT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWDEVT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDEVT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:19:59 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:58674 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751171AbWDEVT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:19:58 -0400
Date: Wed, 5 Apr 2006 22:19:55 +0100 (BST)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Jan Niehusmann <jan@gondor.com>
cc: Takashi Iwai <tiwai@suse.de>, Ken Moffat <zarniwhoop@ntlworld.com>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Slab corruptions & Re: 2.6.17-rc1: Oops in sound
 applications
In-Reply-To: <20060405121537.GA4807@knautsch.gondor.com>
Message-ID: <Pine.LNX.4.63.0604052218280.8850@deepthought.mydomain>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
 <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de>
 <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de>
 <20060404231911.GA4862@knautsch.gondor.com> <20060405002846.GA5201@knautsch.gondor.com>
 <20060405090117.GB4794@knautsch.gondor.com> <s5h1wwcp93l.wl%tiwai@suse.de>
 <20060405121537.GA4807@knautsch.gondor.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-222924853-1144271995=:8850"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-222924853-1144271995=:8850
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT

On Wed, 5 Apr 2006, Jan Niehusmann wrote:

> On Wed, Apr 05, 2006 at 01:14:54PM +0200, Takashi Iwai wrote:
> > Try the patch below.  The change in pcm_native.c may be unnecessary,
> > but it's better so.
> > If it works, I'll submit the patches with a proper log.
> 
> The patch (applied to 2.6.17-rc1) does fix the oops, but sound is still
> garbled with twinkle using /dev/dsp. 

 As a simple user of (only) playback, it fixes it.  Thanks to you both.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
---1463809536-222924853-1144271995=:8850--
