Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUGAE6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUGAE6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 00:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUGAE6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 00:58:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:48585 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263942AbUGAE6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 00:58:41 -0400
Date: Wed, 30 Jun 2004 21:57:25 -0700
From: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How NOT to have already compiled modules (auto)load?
Message-ID: <20040701045725.GC2150@kroah.com>
References: <40E37954.3080201@thinrope.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E37954.3080201@thinrope.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 11:39:16AM +0900, Kalin KOZHUHAROV wrote:
> Sorry for the fuzzy subject, I couldn't formulate it better.
> 
> I was trying to find info on that on Google, man and Documentation/*, but 
> to no avail...
> 
> I have a laptop with USB CD-ROM that is very rarely attached/used.
> I have sr_mod, etc. compiled as modules.
> On every boot it gets autoloaded, despite the fact that CD-ROM is not 
> connected (no, I don't have another).
> 
> My question is is there any good(tm) way to prevent this?
> One way I could think is to rename the module, but that is a bit bad.
> Is there a way to blacklist some modules?

/etc/hotplug/blacklist will prevent the hotplug scripts from loading the
module automatically.

Hope this helps,

greg k-h
