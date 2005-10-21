Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVJUAnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVJUAnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 20:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVJUAnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 20:43:08 -0400
Received: from smtp-out.google.com ([216.239.45.12]:35323 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964825AbVJUAnH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 20:43:07 -0400
Message-ID: <4a45da430510201742q1c4d5532oe64a77be72e7eff8@mail.google.com>
Date: Thu, 20 Oct 2005 17:42:50 -0700
From: Jonathan Mayer <jonmayer@google.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] added sysdev attribute to sysdev show/store methods - for linux-2.6.13.4
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20051021002631.GA18404@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com>
	 <d120d5000510201459y25a2c8e5v55bf830c445c9dbf@mail.gmail.com>
	 <4a45da430510201503v74874acoca37bba3aa5a2d07@mail.google.com>
	 <d120d5000510201603n50c068dcyade2ce2cfd2311e0@mail.gmail.com>
	 <4a45da430510201607x78c5e432r5d641c46dd15eeaa@mail.google.com>
	 <20051021002631.GA18404@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is a good idea, if someone needs access to that attribute
> information.  But for now, no one does.  When they do, I'll be glad to
> accept the patch.

Hi Greg,

My only concern, then, is that by the time somebody needs this patch,
the set of sysdev objects will have grown, requiring a big patch
instead of a small one.  I would also argue that even existing sysdev
objects could be rewritten and cleaned up slightly (remove
proliferation of methods) by using the attribute.

If you like, I could try doing that and submit it as part of this patch...

Thanks!

 - Jonathan.
