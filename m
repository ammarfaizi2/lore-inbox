Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVFTVFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVFTVFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVFTU5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:57:06 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:9642 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262444AbVFTUpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:45:25 -0400
Date: Mon, 20 Jun 2005 22:45:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested?
Message-ID: <20050620204533.GA9520@ucw.cz>
References: <20050620155720.GA22535@ucw.cz> <005401c575b3_5f5bba90_600cc60a@amer.sykes.com> <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620165703.GB477@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 06:57:04PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > I don't think they have anything in the BIOS related to the HDAPS, else they
> > > would have put something in it. (You can't even disable the chip in the
> > > BIOS) I just think is the accelerometer, there, by itself with an extra card
> > > they added.
> >  
> > Well, some piece of software needs to park the HDD when the notebook is
> > falling, and that piece of software should better be running since the
> > notebook is powered on. Hence my suspicion it's in the BIOS. It doesn't
> > have to be visible to the user, at all.
> 
> Actually yes, it needs to be visible to the user and no, it probably
> should not run during boot.  If user is in plane/train,
> accellerometers will basically detect problems all the time; still you
> want to use the computer.

It likely won't. What it does is that it detects a situation with no
gravity - free fall.

> (And you still want the machine to boot => default == fall detection off).

It will boot. It may boot slower if you're jumping from an airplane at
the time, but it'll just park the heads now and then, which, with
IBM/Hitachi drives doesn't take long.

> IIRC there's windows program to control it.
 
That's likely. What good would a feature be for marketing if it wasn't
visible to the user. ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
