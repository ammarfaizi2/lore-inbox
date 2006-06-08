Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWFHSRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWFHSRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWFHSRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:17:18 -0400
Received: from sc-outsmtp1.homechoice.co.uk ([81.1.65.35]:10501 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S964867AbWFHSRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:17:17 -0400
Subject: Re: [linuxsh-dev] [Alsa-devel] [PATCH] Add support
	for	Yamaha	AICA	sound on	SEGA Dreamcast
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       linux-sh <linuxsh-dev@lists.sourceforge.net>
In-Reply-To: <s5hlks82av5.wl%tiwai@suse.de>
References: <1149201071.9032.13.camel@localhost.localdomain>
	 <1149334788.9065.5.camel@localhost.localdomain>
	 <s5hslmimvh5.wl%tiwai@suse.de>
	 <1149635448.5154.7.camel@localhost.localdomain>
	 <s5h8xo970q7.wl%tiwai@suse.de>
	 <1149704202.5087.6.camel@localhost.localdomain>
	 <s5hlks82av5.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 19:16:58 +0100
Message-Id: <1149790618.6041.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 12:35 +0200, Takashi Iwai wrote:

> 
> It's uncoventional that a work struct is re-initialized on the fly.
> 
> IMO, it's better to introduce a flag indicating the stream is already
> running and use a single function/work struct.  For example,

Yes, I've did this sort of thing last night :)

