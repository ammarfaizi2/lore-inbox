Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTEMSGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTEMSEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:04:24 -0400
Received: from main.gmane.org ([80.91.224.249]:29320 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263397AbTEMSDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:03:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: Re: [dri] x startup hangs again... ~2.5.69-bk5
Date: Tue, 13 May 2003 20:11:08 +0200
Message-ID: <slrnbc2d9s.cv.andreashappe@flatline.ath.cx>
References: <slrnbc25b6.e5.andreashappe@flatline.ath.cx> <20030513165647.GA1056@suse.de>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030513165647.GA1056@suse.de>, Dave Jones wrote:
> On Tue, May 13, 2003 at 05:55:18PM +0200, Andreas Happe wrote:
> > used hardware:
> > 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
> > M6 LY
> 
> Can you try with the drivers/char/agp changes backed out ?

ok, i've tried all snapshots starting with today's bk patch. bk[567]
crashed upon x startup. bk[34] crashed while moving windows around (i'm
using the ion window manager, so it got more of a "beam window around").
bk2 and vanillia seemed stable, but both crashed after a short time.

Then I've looked at my /etc/X11/XF86Config-4 and found my "aggressive" AGP
Settings (enabled 'fast write', agpmode set to 4), i'm now running
with bk2 with agpmode set to 2, seems stable. I will try bk-5 after some
working with bk2.
 
> What motherboard chipset ?

intel 830m

andreas

