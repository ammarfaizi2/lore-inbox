Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbUC3S5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbUC3S5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:57:09 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:8064 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263837AbUC3Szv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:55:51 -0500
Date: Tue, 30 Mar 2004 20:55:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/44] Support for scroll wheel on Office keyboards
Message-ID: <20040330185552.GB319@ucw.cz>
References: <1079446776784@twilight.ucw.cz> <10794467761141@twilight.ucw.cz> <20040327195535.GA11610@wsdw14.win.tue.nl> <20040330130942.GC3084@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330130942.GC3084@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 03:09:43PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Apart from this concrete question - the number of keyboards and
> > mice is very large and growing by the day. I think it is hopeless
> > to try and teach the kernel about all details of each of them.
> > I think we should try to go for a keyboard/mouse definition file
> > maintained in user space and fed to the kernel.
> 
> Well, if it can be maintained in userspace, it should be possible to maintain, too.
> Plus it seems to me that some keyboards are compatible with others... for example arima
> seems to generate same keycodes for "vol+" and "vol-" as compaq nx5000...

I'm not interested in maintaining this in the kernel - the database
would be rather large (say 100 kbyte) ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
