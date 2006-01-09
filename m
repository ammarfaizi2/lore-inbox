Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWAIJEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWAIJEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWAIJEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:04:52 -0500
Received: from styx.suse.cz ([82.119.242.94]:42931 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751035AbWAIJEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:04:51 -0500
Date: Mon, 9 Jan 2006 10:04:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] It's UTF-8
Message-ID: <20060109090448.GA8505@ucw.cz>
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru> <Pine.LNX.4.61.0601082245090.17804@yvahk01.tjqt.qr> <200601082210.09536.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601082210.09536.s0348365@sms.ed.ac.uk>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 10:10:09PM +0000, Alistair John Strachan wrote:

> On Sunday 08 January 2006 21:46, Jan Engelhardt wrote:
> > >Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >
> > I'd say ACK. However,
> >
> > > iocharset=name	Character set to use for converting from Unicode to
> > > 		ASCII.  The default is to do no conversion.  Use
> > >-		iocharset=utf8 for UTF8 translations.  This requires
> > >+		iocharset=utf8 for UTF-8 translations.  This requires
> > > 		CONFIG_NLS_UTF8 to be set in the kernel .config file.
> >
> > If you are really nitpicky about the "-", then it should also be
> > "iocharset=utf-8" (and whereever else). Or what's the real purpose of
> > adding the dashes in only half of the places, then?
> 
> Also what's "Unicode 16" as used in several places in the kernel. Surely this 
> should be changed to UTF-16, which is the _encoding_ for the unicode 
> character space.
 
It might also be UCS-2 and not UTF-16 in some places. They do differ.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
