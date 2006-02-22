Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWBVGU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWBVGU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 01:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWBVGU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 01:20:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:26325 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751346AbWBVGU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 01:20:29 -0500
Date: Tue, 21 Feb 2006 21:39:18 -0800
From: Greg KH <gregkh@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EXPORT_SYMBOL_GPL_FUTURE()
Message-ID: <20060222053918.GA27267@suse.de>
References: <20060208062007.GA7936@kroah.com> <43EE9EC0.2030403@rtr.ca> <20060212041522.GA29935@suse.de> <43EEB6FE.7000701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EEB6FE.7000701@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 11:18:06PM -0500, Mark Lord wrote:
> Greg KH wrote:
> >On Sat, Feb 11, 2006 at 09:34:40PM -0500, Mark Lord wrote:
> >>Greg KH wrote:
> >>>So, here's a patch that implements EXPORT_SYMBOL_GPL_FUTURE().  It
> >>>basically says that some time in the future, this symbol is going to
> >>>change and not be allowed to be called from non-GPL licensed kernel
> >>>modules.
> >>The wording and intent here are incorrect.
> >>
> >>All kernel modules are already *GPL licensed*,
> >>whether the authors think so or not.
> >>
> >>So this patch (if it goes through), should be reworded
> >>so as not to muddy those waters (as the above excerpt does).
> >
> >Care to provide some text that you feel will be better?
> 
> Just something simple, like this rewording of your original post:
> 
> >>> So, here's a patch that implements EXPORT_SYMBOL_GPL_FUTURE().  It
> >>> basically says that some time in the future, this symbol is going to
> >>> change and not be allowed to be called from
> ...kernel modules that don't include MODULE_LICENSE("GPL") in the source.

Ok, I've tweaked it to look more like this.

thanks,

greg k-h
