Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVH3QBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVH3QBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVH3QBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:01:16 -0400
Received: from styx.suse.cz ([82.119.242.94]:62436 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751447AbVH3QBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:01:15 -0400
Date: Tue, 30 Aug 2005 18:01:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
Message-ID: <20050830160125.GA15126@midnight.suse.cz>
References: <20050830093715.GA9781@midnight.suse.cz> <43147FF1.60707@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43147FF1.60707@tls.msk.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 07:49:05PM +0400, Michael Tokarev wrote:
> Vojtech Pavlik wrote:
> > Hi!
> > 
> > The D-Link DWL-G730AP devices from the Kernel Summit run Linux, And it's
> > likely a GPL violation, too, since sources are nowhere to be found.
> > 
> > They're based on a Marvell Libertas AP-32 (ARM9) design, similar
> > to the ASUS WL-530g. A bootlog from the ASUS (which has telnet enabled
> > for some reason, and thus can be logged in) is at the end of the mail.
> > 
> > A firmware image is available from D-Link ([URL removed]) and it seems
> > to be composed of compressed blocks padded by zeroes. I haven't verified
> > yet that it's indeed a compressed kernel, cramfs, etc, but it seems
> > quite likely.
> 
> Why [URL removed] ? ;)

See the comment at the end of the mail. I tried to send the mail twice
already, and with the URLs in, it wasn't delivered. Probably some spam
filter at kernel.org ate it.

> There's an ongoing project to "bring some power" into other D-Link
> devices (from DSL series; one of them, DSL-G604T (which I own) has
> an access point too) at http://mcmcc.bat.ru/dlinkt/ .  This stuff is
> also based on the same design, it seems (but I know right to nothing
> about all this arm stuff - wasn't even able to compile a cross-gcc
> for it yet).  McMCC (the author of this whole work) figured out the
> layout of the firmware images and mtd devices, and got D-Link stuff
> (out of http://ftp.dlink.ru/pub/ADSL/GPL_source_code/ ) to build and
> run on those boards...

These seem to have an entirely different architecture. The DSL's are
Texas Instrument MIPS, while the Libertas is an Marvell ARM.

> BTW, DSL series has telnet by default (user root, password is the
> one set in the admin interface, default is 'admin').  And the whole
> webinterface looks very similar (but this DWL-G730AP device has some
> "advanced" controls for the wireless component which are absent in
> my DSL-G604T).
 
The web interface is likely the only part done by D-Link. In the
DWL-G730AP, the rest (board design, etc) was done by Marvell and Global
Sun Technology. The PCB name is "WL AP 2454 NM1 VER:1.1".

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
