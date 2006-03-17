Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWCQTS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWCQTS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWCQTS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:18:27 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:30987 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030269AbWCQTS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:18:26 -0500
Date: Fri, 17 Mar 2006 14:14:52 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Andreas Happe <andreashappe@snikt.net>, Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org, zhu.yi@intel.com
Subject: Re: 2.6.16-rc5-mm2: IPW_QOS: two remarks
Message-ID: <20060317191447.GC21830@tuxdriver.com>
Mail-Followup-To: Andreas Happe <andreashappe@snikt.net>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	netdev@vger.kernel.org, zhu.yi@intel.com
References: <20060303045651.1f3b55ec.akpm@osdl.org> <20060303152641.GR9295@stusta.de> <200603050146.27529.andreashappe@snikt.net> <20060307170642.GE3974@stusta.de> <20060303045651.1f3b55ec.akpm@osdl.org> <20060303152641.GR9295@stusta.de> <200603050146.27529.andreashappe@snikt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307170642.GE3974@stusta.de> <200603050146.27529.andreashappe@snikt.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 01:46:26AM +0100, Andreas Happe wrote:

> Add the following config entries for the ipw2200 driver to 
> drivers/net/wireless/Kconfig
>  * IPW2200_MONITOR
> 	enables Monitor mode, as this seems to generate lots of firmware errors
> 	it depends upon BROKEN
>  * IPW2200_QOS
> 	enables QoS feature - this is under development right now, so it depends 
> 	upon EXPERIMENTAL.

Your patch appears to be whitespace-damaged.  Please configure your
mailer appropriately.

Also, please stick to the patch format described here:

	http://linux.yyz.us/patch-format.html

In particular, don't put anything in the message that doesn't belong
in the kernel's changelog, such as email-ish messages.

On Tue, Mar 07, 2006 at 06:06:42PM +0100, Adrian Bunk wrote:
> On Sun, Mar 05, 2006 at 01:46:26AM +0100, Andreas Happe wrote:
> > On Friday 03 March 2006 16:26, Adrian Bunk wrote:
> >...
> > > - please add a help text
> > 
> > i could add some stuff about WMM to its help text, but I think someone more 
> > involved with the ipw2200-project should do that.
> 
> Even a short help text is better than no help text.

I agree w/ Adrian.  Since you are touching it, please put something
appropriate in the Kconfig file.  Zhu Yi may be able to help if you
aren't sure what the help text should say.

Thanks!

John
-- 
John W. Linville
linville@tuxdriver.com
