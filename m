Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264165AbRFHQPo>; Fri, 8 Jun 2001 12:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFHQPe>; Fri, 8 Jun 2001 12:15:34 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:38017 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S264165AbRFHQP2>;
	Fri, 8 Jun 2001 12:15:28 -0400
Date: Fri, 8 Jun 2001 18:15:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010608181521.A1998@suse.cz>
In-Reply-To: <20010606125556.A1766@suse.cz> <20010606232133.E38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010606232133.E38@toy.ucw.cz>; from pavel@suse.cz on Wed, Jun 06, 2001 at 11:21:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 11:21:34PM +0000, Pavel Machek wrote:

> > If you still have your 3-button MouseSystems (or any other serial) mouse
> > somewhere in your driver, forgotten becase of the incredibly slow update
> > rate causing so much jumping of the pointer on the screen that it is
> > unusable, you may want to pull it out and give it a try.
> > 
> > Or if you're still using it with some old 486 computer, this driver is
> > for you. 
> > 
> > What it does is that it enhances the update rate from 24 (with current
> > GPM and X drivers) to 96. This is almost what the best USB mice do.
> 
> What's the "prediction" stuff? Does it mean you are guessing some values
> by interpolation?

Extrapolation, yes.

> [If so, what kind of update rate would it do on USB?]

It wouldn't make any difference - on USB you always get whole packets,
while over serial port the data is processed byte by byte and thus we
know a little of the information before the whole packet arrives.

-- 
Vojtech Pavlik
SuSE Labs
