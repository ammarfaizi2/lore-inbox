Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWBTBBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWBTBBR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 20:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWBTBBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 20:01:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42112 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751173AbWBTBBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 20:01:16 -0500
Date: Mon, 20 Feb 2006 02:01:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, Phillip Susi <psusi@cfl.rr.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060220010102.GB15965@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0602191138470.9165-100000@netrider.rowland.org> <43F8C464.3000509@cfl.rr.com> <20060219194343.GA15311@elf.ucw.cz> <20060220005617.GB90469@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220005617.GB90469@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 01:56:17, Olivier Galibert wrote:
> On Sun, Feb 19, 2006 at 08:43:44PM +0100, Pavel Machek wrote:
> > Kernel can not tell the diference, and just because you don't like the
> > behaviour does not mean we have to work around hardware limitation.
> > 
> > You deal with it. Post a patch.
> 
> It would take more than one patch, but it could be done:

Actually, if you really want to do this, it would probably make sense
to do at blockdevice level -- with device mapper magic or something.

That way you could prompt user "return that flash driver, I still want
to write to it" after surprise unplug, etc. And suspend is special
case of surprise unplug, then replug.

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
