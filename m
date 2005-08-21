Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbVHVWZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbVHVWZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVHVWZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:25:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751412AbVHVWZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:46 -0400
Date: Sun, 21 Aug 2005 22:50:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA USB Controller - (Wrong ID) ??
Message-ID: <20050821205027.GA9146@ucw.cz>
References: <9a8748490508191153512e2db4@mail.gmail.com> <43067527.1000708@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43067527.1000708@tremplin-utc.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 02:11:19AM +0200, Eric Piel wrote:
> Hello,
> 
> 19.08.2005 20:53, Jesper Juhl wrote/a écrit:
> >I've just noticed that my USB controller(s) show up as having "Wrong
> >ID" and now I'm wondering what exactely that means and what I can do
> >about it  (kernel 2.6.13-rc6-mm1 in case it matters).
> >
> >Is it a wrong PCI ID? If so, how's the controller recognized at all?
> >
> >I stopped by http://pci-ids.ucw.cz/iii// which had an entry saying :
> >
> >0925	VIA Technologies, Inc. (Wrong ID)
> >    	Wrong ID used in subsystem ID of VIA USB controllers.
> >
> I've never heard of this before. However, cheking the list shows that 
> every vendor which has a "Wrong ID" entry also a normal one. So my guess 
> is that "wrong ID" means that somewhere in the process of putting the 
> PCI ID (during the design of the device) someone mistook which ID to 
> put. So this would mean that your device doesn't have the official ID of 
> VIA, but it uses an unofficial one (famous enough to be listed though). 
> Nothing to worry about.
> 
> :
> >00:04.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
> >controller] (rev 16) (prog-if 00 [UHCI])
> >        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
> 
> >
> >Can anyone explain this to me?     The controllers are working just
> >fine, so it's not too important, I'm just a currious nature :)
> 
> Well, as I said before, it's just pure guess, but it's cool to invent 
> stories ;-)
 
It's a correct guess, though. They mixed up the vendor and device IDs in
the subsystem ID of their USB controllers.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
