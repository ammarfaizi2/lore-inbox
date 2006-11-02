Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752644AbWKBVan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbWKBVan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbWKBVan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:30:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:23765 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752644AbWKBVam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:30:42 -0500
Date: Thu, 2 Nov 2006 13:29:57 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Rajesh Shah <rajesh.shah@intel.com>, toralf.foerster@gmx.de,
       Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>,
       Auke Kok <auke-jan.h.kok@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: 2.6.19-rc4: known unfixed regressions
Message-ID: <20061102212957.GA16201@kroah.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061031195654.GV27968@stusta.de> <200611022102.02302.rjw@sisk.pl> <Pine.LNX.4.64.0611021240300.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611021240300.25218@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 12:54:02PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 2 Nov 2006, Rafael J. Wysocki wrote:
> 
> > Can we please add the following two to the list of known regressions:
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=7082
> 
> Ok, I think I'll just revert it.
> 
> Decoding the PCI IO range is fine - even if a driver has detached, the 
> kernel knows where the PCI devices are, and won't re-use the range. So 
> while the patch that triggers the problem seems valid in itself, it's 
> probably not worth the pain to apply it at this point. So I think I'll 
> revert it - the rationale for the patch was fairly weak.
> 
> Greg, or would you prefer to do the honors?

I'll queue it up.

thanks,

greg k-h
