Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272072AbTG2UhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272073AbTG2UhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:37:11 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:58510 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S272072AbTG2UhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:37:07 -0400
Date: Tue, 29 Jul 2003 22:37:03 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: neofb problems with 2.6.0-test1-ac3 etc. -- kernel-2.6.x ignoramus
Message-ID: <20030729203703.GG30351@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030726124907.GB22804@charite.de> <Pine.LNX.4.44.0307291807490.5874-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307291807490.5874-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Simmons <jsimmons@infradead.org>:

> > fbset -depth 16
> > 
> > fixes things again. To see what I see, look at:
> > http://sbserv.stahl.bau.tu-bs.de/~hildeb/fbfubar/
> 
> This is because the X server is not fbdev aware. Try adding the UseFBDev 
> option in your XF86Config. That shoudl fix your problems.

Sorry, but this can't be: How comes the SAME X Server with the SAME
XF86Config works OK with 2.4.22-pre8, but not with 2.6.x?

This is on the SAME machine, just with different kernel. Generally,
all 2.4.x kernels don't show the problem, but 2.6.x does.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
