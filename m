Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVBMSP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVBMSP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 13:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVBMSP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 13:15:28 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:55008 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261291AbVBMSPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 13:15:21 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050213120100.GB1978@ucw.cz>
References: <20050211201013.GA6937@ucw.cz>
	 <1108227679.12327.24.camel@localhost> <20050212183440.GC8170@ucw.cz>
	 <1108289100.5978.18.camel@localhost>  <20050213120100.GB1978@ucw.cz>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 19:14:44 +0100
Message-Id: <1108318484.5978.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 13.02.2005, 13:01 +0100 schrieb Vojtech Pavlik: 
> On Sun, Feb 13, 2005 at 11:05:00AM +0100, Kenan Esau wrote:
>  
> > > > This
> > > > sequence does not always work and there is not something like a "magic
> > > > knock sequence".
> > > 
> > > You mean that the only needed bit is setting the resolution to '7'?
> > 
> > The lifebook touchscreen has some extensions to the standard protocol:
> > 
> > 0xe8 0x06: Stop absolute coordinate output 
> > 0xe8 0x07: Start absolute coordinate outpout (3-byte packets)
> > 0xe8 0x08: Start absolute coord. output with 6-byte packets
> 
> Are the 6-byte packets carrying any more information than the 3-byte
> packets do, for example pressure? Would it be useful to go for the
> 6-byte mode instead in the driver?

No the 6-byte mode does not carry any more information. Sorry but no
pressure-info... 

> Have you tried whether the controller responds to the GETID (f2),
> GETINFO (e9) and POLL (eb) commands? Maybe we could detect it that way.

I have to try those commands and check the response. I know that they
are supported but I have never tried them.

[...]

> > If you agree I will take your patch as the basis and make it work. Now I
> > know how you want it to look like.
> 
> That would be very much appreciated.

OK. I'll send you a new patch within the next week.

