Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVBPVei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVBPVei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVBPVei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:34:38 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:14781 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262024AbVBPVeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:34:36 -0500
Date: Wed, 16 Feb 2005 22:35:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050216213508.GD3001@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz> <1108578892.2994.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108578892.2994.2.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 07:34:52PM +0100, Kenan Esau wrote:

> > > +
> > > +        /* 
> > > +           Enable absolute output -- ps2_command fails always but if
> > > +           you leave this call out the touchsreen will never send
> > > +           absolute coordinates
> > > +        */ 
> > > +        param = 0x07;
> > > +        ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
> > 
> > Have you checked whether really the touchscreen sends a 0xfe error back,
> > or some other value, or timeout? i8042.debug=1 is your friend here.
> 
> Yes the answer is 0xfe. 

Would you be so kind to post the 'dmesg' log?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
