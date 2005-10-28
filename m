Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbVJ1LNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbVJ1LNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 07:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVJ1LNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 07:13:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8723 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965207AbVJ1LNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 07:13:33 -0400
Date: Fri, 28 Oct 2005 12:13:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DRIVER MODEL: Get rid of the obsolete tri-level suspend/resume callbacks
Message-ID: <20051028111327.GK5044@flint.arm.linux.org.uk>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, Greg K-H <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <11304810272893@kroah.com> <113048102730@kroah.com> <s5hmzku9cv8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hmzku9cv8.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:04:11PM +0200, Takashi Iwai wrote:
> At Thu, 27 Oct 2005 23:30:27 -0700,
> Greg KH wrote:
> > 
> > --- a/Documentation/driver-model/driver.txt
> > +++ b/Documentation/driver-model/driver.txt
> > @@ -196,67 +196,11 @@ it into a supported low-power state.
> >  
> >  	int	(*suspend)	(struct device * dev, pm_message_t state, u32 level);
> >  
> 
> Shouldn't this be also changed without level argument?
> 
> 
> > +suspend is called to put the device in a low power state.
> >  
> >  	int	(*resume)	(struct device * dev, u32 level);
> >  
> 
> Ditto.

Probably.  Please send a patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
