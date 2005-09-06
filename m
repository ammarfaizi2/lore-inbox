Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVIFL5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVIFL5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVIFL5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:57:53 -0400
Received: from styx.suse.cz ([82.119.242.94]:50306 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964829AbVIFL5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:57:52 -0400
Date: Tue, 6 Sep 2005 13:57:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hugo Vanwoerkom <hvw59601@yahoo.com>
Cc: Aivils Stoss <aivils@unibanka.lv>, linux-kernel@vger.kernel.org,
       bruby <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: INPUT: keyboard_tasklet - don't touch LED's of already grabed device
Message-ID: <20050906115750.GA10001@ucw.cz>
References: <200509061034.55963.aivils@unibanka.lv> <20050906115228.80715.qmail@web31008.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906115228.80715.qmail@web31008.mail.mud.yahoo.com>
X-Bounce-Cookie: It's a lemmon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 04:52:28AM -0700, Hugo Vanwoerkom wrote:
> 
> 
> --- Aivils Stoss <aivils@unibanka.lv> wrote:
> 
> > Hi, Vojtech!
> > 
> > Recent kernels allow exclusive usage of input device
> > when
> > input device is grabed. keyboard_tasklet does not
> > check
> > device state and switch LED's of all keyboards.
> > However
> > grabed device may be use another LED steering code.
> > 
> > This patch forbid keyboard_tasklet switch LED's of
> > grabed devices.
> > 
> > Aivils Stoss
> 
> 
> While trying this with 2.6.12 it gets a compilation
> error. Not when you move the added statements after
> the structure declaration.
> 
> Is that me heading for them thar hills?
 
The patch probably wasn't tested. ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
