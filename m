Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWGIPRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWGIPRj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 11:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWGIPRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 11:17:39 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35280 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161016AbWGIPRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 11:17:38 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, alsa-devel@alsa-project.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <p737j2potzr.fsf@verdi.suse.de>
References: <20060707231716.GE26941@stusta.de>
	 <p737j2potzr.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 11:18:19 -0400
Message-Id: <1152458300.28129.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 01:50 +0200, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> > 
> > Q: What about the OSS emulation in ALSA?
> > A: The OSS emulation in ALSA is not affected by my patches
> >    (and it's not in any way scheduled for removal).
> 
> I again object to removing the old ICH sound driver.
> It does the same as the Alsa driver in much less code and is ideal
> for generic monolithic kernels

It doesn't do the same thing - software mixing is impossible with OSS.

Lee

