Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWGEKjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWGEKjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWGEKjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:39:01 -0400
Received: from khc.piap.pl ([195.187.100.11]:14540 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964812AbWGEKjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 06:39:00 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Benny Amorsen <benny+usenet@amorsen.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	<20060701170729.GB8763@irc.pl>
	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	<20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	<20060703205523.GA17122@irc.pl>
	<1151960503.3108.55.camel@laptopd505.fenrus.org>
	<44A9904F.7060207@wolfmountaingroup.com>
	<20060703232547.2d54ab9b.diegocg@gmail.com>
	<m3r711u3yk.fsf@ursa.amorsen.dk> <44AB3E4C.2000407@tmr.com>
	<44AB4A68.90301@zytor.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 05 Jul 2006 12:38:59 +0200
In-Reply-To: <44AB4A68.90301@zytor.com> (H. Peter Anvin's message of "Tue, 04 Jul 2006 22:13:12 -0700")
Message-ID: <m3k66sjpz0.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> The real solution for it is snapshots.

Or a continuous log. Since we already use a journal we could possibly
make its contents stay forever (and the admin should be able to define
the "forever").
-- 
Krzysztof Halasa
