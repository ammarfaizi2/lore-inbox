Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbUDTKRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUDTKRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 06:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUDTKRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 06:17:40 -0400
Received: from main.gmane.org ([80.91.224.249]:12681 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262448AbUDTKRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 06:17:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: standart events for hotkeys?
Date: Tue, 20 Apr 2004 12:17:28 +0200
Message-ID: <MPG.1aef16eec318a14d989695@news.gmane.org>
References: <200404200042.24671.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oblomov.dipmat.unict.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler (volny.cz) wrote:
> Hi guys,
> 
> I have a question related to keyboard and hotkeys.
> 
> Does any standart exist for hotkeys and their returned events?
> I have 2 keyboards with hotkeys, one on laptop (acerhk operated) and one 
> wireless (BlueZ bthid operated) and both returns different codes in xev when 
> same keys are pressed
> 
> mail
> browser
> etc.
> 
> Maybe these should be standardised in all drivers? Can we start same kind of 
> list, where will be all events stored and then translated by all drivers the 
> same?
> 
> Now users can't use one hotkeys configuration on different keyboards so these 
> could be renamed to hellkeys :)
> 
> Your opinions?

X already has codes for many of the hotkeys defined in. They have 
names like XF86AudioMute etc. The inet rules define the proper 
scancode -> keycode assignment for X for many keyboards modules.

Yes, I think it would be an interesting idea to have some kind of 
standardization of this for the Linux kernel as well, but before 
thinking about this (or at the same time) it would be nice if we 
could fix the bug in the atkbd driver that makes some of the hotkeys 
that use extended keycodes inaccessible or "shifty".

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

