Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWBSA53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWBSA53 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWBSA53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:57:29 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:36839
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964782AbWBSA52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:57:28 -0500
Date: Sat, 18 Feb 2006 16:57:16 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs-related oops during module unload (2.6.16-rc2)
Message-ID: <20060219005716.GA5800@kroah.com>
References: <20060211220351.GA3293@localhost.localdomain> <20060211224526.GA25237@kroah.com> <20060212052751.GB3293@localhost.localdomain> <20060212053849.GA27587@kroah.com> <20060216215023.GA30417@kroah.com> <20060219004751.GE3293@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219004751.GE3293@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 06:47:51PM -0600, Nathan Lynch wrote:
> Sorry for the delay.
> 
> Tested against 2.6.16-rc4-ish, and it seems to do the right thing --
> modprobe -r says the module is busy while the refcnt attribute is
> open.  The module is allowed to unload once the file is closed.

Great, thanks for trying it out and letting me know.

> I didn't verify the other stuff your patch changes, though.

Heh, well if it all still works, that's pretty much proof that the other
stuff was correct too :)

thanks,

greg k-h
