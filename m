Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTDVXAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 19:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263896AbTDVXAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 19:00:11 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:478 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263900AbTDVXAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 19:00:09 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Vagn Scott <vagn@ranok.com>
Date: Wed, 23 Apr 2003 01:12:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [2.5.68] no console messages after switch to FB (matrox
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <154A2DE0E65@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Apr 03 at 18:07, Vagn Scott wrote:
> Petr Vandrovec wrote:
> > 
> > > CONFIG_FB=y
> > > CONFIG_FB_VESA=y
> > > CONFIG_VIDEO_SELECT=y
> > > CONFIG_FB_MATROX=y
> > 
> > Are you sure that your boot messages are directed to the matroxfb and
> > not to the vesa?
> > 
> > In the past keyword for selecting matroxfb options was 'video=matrox:...',
> > while now it is 'video=matroxfb:...', so you may have to modify your
> > lilo.conf line (and do not ask me why these two letters were added if
> > we have video= prefix... I do not know).
> 
> Adding video=matroxfb did the trick.  Thanks for the tip.
> 
> I still don't understand the logic of it, though.
> If the kernel can find the resources to present the logo,
> why can't it just keep using those resources for the rest
> of the boot?

Ask James... I assume that new fbdev paints logo on all fbdevs it finds...
                                                    Petr Vandrovec
                                                    

