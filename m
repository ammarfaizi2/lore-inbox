Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTI2KCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 06:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbTI2KCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 06:02:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6296 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263018AbTI2KCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 06:02:19 -0400
Date: Mon, 29 Sep 2003 12:01:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Michael Frank <mhf@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG?] SIS IDE DMA errors
Message-ID: <20030929100130.GA9322@ucw.cz>
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <200309262208.30582.mhf@linuxmail.org> <yw1x3cejlk34.fsf@users.sourceforge.net> <200309262332.30091.mhf@linuxmail.org> <20030926165957.GA11150@ucw.cz> <yw1x7k3vjw8o.fsf@users.sourceforge.net> <20030926175358.GA12072@ucw.cz> <yw1x3cejjvdw.fsf@users.sourceforge.net> <20030926183323.GA12614@ucw.cz> <yw1xy8w8uey3.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xy8w8uey3.fsf@users.sourceforge.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 11:22:28AM +0200, M?ns Rullg?rd wrote:

> > 08 - 80-wire cables (needed for UDMA44 and higher) NOT installed.
> >      FIFO threshold set to 3/4 for read and to 1/4 for write.
> >
> > 01 - IDE controller in compatibility mode. Native and test modes
> >      disabled. (normal)
> >
> > e6 - PCI burst enable, EDB R-R pipeline enable, Fast postwrite enable,
> >      device ID masqueraded as sis5513 (although real is 5517)
> >      channels 0 and 1 enabled in normal mode
> >
> > 51 - Postwrite enabled on hda and hdc, prefetch on hda only
> >
> > 00 02 - 512 bytes prefetch size for hda
> > 00 02 - 512 bytes prefetch size for hdc
> >
> > All this is OK, possibly except for the 80-wire cable not being present,
> > but if this is a notebook, there might be a completely different cable
> > type than what's standard, and the detection might not work there.
> 
> I've got no idea what the cable is like.  Is there anything to be
> learned from opening the beast?  Anything in particular to look for?

Not really, sorry.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
