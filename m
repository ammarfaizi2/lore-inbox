Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTDVPge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTDVPge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:36:34 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:47825 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263202AbTDVPgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:36:32 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Vagn Scott <vagn@ranok.com>
Date: Tue, 22 Apr 2003 17:48:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [2.5.68] no console messages after switch to FB (matrox
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <14D3CAA578B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Apr 03 at 13:39, Vagn Scott wrote:
> config is below
> Sun Apr 20 18:20:24 EDT 2003
> 2.5.68
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-2.5.68.gz
> (please CC: me, as I'm not on the list)
> --------------------------------
> 1. While booting things look normal
> until the lovely little Tux logo appears,
> then no more console messages are written to the screen.
> The box still boots, however.
> 
> Turned off logo, same thing: as soon as it switches
> to the FB no more boot messages appear.

Some special boot time options?

> CONFIG_FB=y
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FB_MATROX=y

Are you sure that your boot messages are directed to the matroxfb and
not to the vesa?

In the past keyword for selecting matroxfb options was 'video=matrox:...',
while now it is 'video=matroxfb:...', so you may have to modify your
lilo.conf line (and do not ask me why these two letters were added if
we have video= prefix... I do not know).
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

