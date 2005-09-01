Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbVIAVuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbVIAVuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVIAVuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:50:16 -0400
Received: from styx.suse.cz ([82.119.242.94]:16529 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030422AbVIAVuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:50:15 -0400
Date: Thu, 1 Sep 2005 23:50:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Mark Lord <mlord@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
Message-ID: <20050901215024.GA2925@midnight.suse.cz>
References: <20050830093715.GA9781@midnight.suse.cz> <4315E0F0.6060209@pobox.com> <20050831205319.A6385@flint.arm.linux.org.uk> <20050831203211.GA13752@midnight.suse.cz> <94E48213-4A1A-4979-B3A7-05E7BBE19AD3@mac.com> <1125545767.12996.21.camel@localhost> <20050901153915.GB1561@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901153915.GB1561@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 05:39:15PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > The 4020 and 0402 look oddly symmetrical to me, but that could just
> > > be my imagination.
> > 
> > All I saw in it was byte n+1 = byte n >> 1. Can't see any use to that
> > either, though. Maybe it's just there to torment reverse engineerers, or
> > trap memory corruption?
> 
> I had seen something like that before -- it was image compression
> and they were using 9bit "bytes"... which worked like obfuscation, too.
 
Yes, if they were using 7bit bytes, that'd explain the 0x81 in the
sequence ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
