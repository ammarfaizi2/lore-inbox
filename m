Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVJUEMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVJUEMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 00:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVJUEMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 00:12:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:59052 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750968AbVJUEML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 00:12:11 -0400
Date: Thu, 20 Oct 2005 21:07:14 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Mayer <jonmayer@google.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH] added sysdev attribute to sysdev show/store methods - for linux-2.6.13.4
Message-ID: <20051021040713.GA17827@kroah.com>
References: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com> <d120d5000510201459y25a2c8e5v55bf830c445c9dbf@mail.gmail.com> <4a45da430510201503v74874acoca37bba3aa5a2d07@mail.google.com> <d120d5000510201603n50c068dcyade2ce2cfd2311e0@mail.gmail.com> <4a45da430510201607x78c5e432r5d641c46dd15eeaa@mail.google.com> <20051021002631.GA18404@kroah.com> <4a45da430510201742q1c4d5532oe64a77be72e7eff8@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a45da430510201742q1c4d5532oe64a77be72e7eff8@mail.google.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 05:42:50PM -0700, Jonathan Mayer wrote:
> > It is a good idea, if someone needs access to that attribute
> > information.  But for now, no one does.  When they do, I'll be glad to
> > accept the patch.
> 
> Hi Greg,
> 
> My only concern, then, is that by the time somebody needs this patch,
> the set of sysdev objects will have grown, requiring a big patch
> instead of a small one.

So?  That's not a big deal, split it into more pieces.  That's what was
done when people did the same for the device attributes.

> I would also argue that even existing sysdev objects could be
> rewritten and cleaned up slightly (remove proliferation of methods) by
> using the attribute.

Now that would be a justification for accepting the patch, and is why I
took it for the device attributes.

> If you like, I could try doing that and submit it as part of this patch...

That would be fine.

thanks,

greg k-h
