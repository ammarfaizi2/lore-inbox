Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVBPSfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVBPSfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 13:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVBPSfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 13:35:53 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:42707 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S262095AbVBPSfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 13:35:47 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050215134308.GE7250@ucw.cz>
References: <20050211201013.GA6937@ucw.cz>
	 <1108457880.2843.5.camel@localhost>  <20050215134308.GE7250@ucw.cz>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 19:34:52 +0100
Message-Id: <1108578892.2994.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 15.02.2005, 14:43 +0100 schrieb Vojtech Pavlik:
> On Tue, Feb 15, 2005 at 09:57:59AM +0100, Kenan Esau wrote:
> > Am Freitag, den 11.02.2005, 21:10 +0100 schrieb Vojtech Pavlik:

[...]

> > +
> > +        /* 
> > +           Enable absolute output -- ps2_command fails always but if
> > +           you leave this call out the touchsreen will never send
> > +           absolute coordinates
> > +        */ 
> > +        param = 0x07;
> > +        ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
> 
> Have you checked whether really the touchscreen sends a 0xfe error back,
> or some other value, or timeout? i8042.debug=1 is your friend here.

Yes the answer is 0xfe. 


