Return-Path: <linux-kernel-owner+w=401wt.eu-S1751333AbXAOS5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbXAOS5S (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbXAOS5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:57:18 -0500
Received: from styx.suse.cz ([82.119.242.94]:49645 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751314AbXAOS5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:57:17 -0500
Date: Mon, 15 Jan 2007 19:56:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jiri Kosina <jikos@jikos.cz>, Simon Budig <simon@budig.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] USB HID: proper LED-mapping (support for SpaceNavigator)
Message-ID: <20070115185656.GB7161@suse.cz>
References: <20070114231135.GA29966@budig.de> <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz> <20070115162541.GA3751@budig.de> <Pine.LNX.4.64.0701151743170.16747@twin.jikos.cz> <20070115183207.GA6792@suse.cz> <1168886290.31200.15.camel@violet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168886290.31200.15.camel@violet>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 07:38:10PM +0100, Marcel Holtmann wrote:
> Hi Vojtech,
> 
> > > No, it didn't disappear, it was just moved to include/linux/hid-debug.h. 
> > 
> > Do you think that makes sense? It's code, not a header file.
> > 
> > > Should I wait for an updated patch that uses hid-debug.h again?
> 
> actually that code shouldn't be in a header file at all. It should be
> drivers/hid/hid-debug.c and the Makefile should compile it conditionally
> depending on a Kconfig option.
 
Agreed. It was a .h file just because of me being lazy.

-- 
Vojtech Pavlik
Director SuSE Labs
