Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266056AbUFEJSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUFEJSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 05:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUFEJSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 05:18:35 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:26241 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S266013AbUFEJSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 05:18:33 -0400
Date: Sat, 5 Jun 2004 11:18:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Pokey the Penguin <pokey@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse/usb interaction fix
Message-ID: <20040605091837.GA1197@ucw.cz>
References: <20040531174012.BA07D2B2B58@ws5-7.us4.outblaze.com> <20040531180341.GA17125@kroah.com> <20040531200120.GA1747@ucw.cz> <20040604203013.GA13414@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604203013.GA13414@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 01:30:13PM -0700, Greg KH wrote:

> > I wrote the patch, SuSE 9.1 is shipping with it - too many BIOSes get
> > the USB support wrong - don't expect keyboards and mice which don't
> > honor the SET_IDLE command, etch. In my experience the BIOS USB support
> > causes much more pain than good, namely preventing the normal PS/2 mice
> > and keyboards to work properly.
> 
> I agree that lots of BIOSes get the USB support wrong, but this patch
> really scares me.  How about we see how it works out in a few SuSE
> releases before adding it to the main kernel tree?

Fine with me. That's one reason why I didn't submit it yet.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
