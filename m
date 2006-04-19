Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWDSU4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWDSU4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWDSU4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:56:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4278 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751230AbWDSU4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:56:45 -0400
Date: Wed, 19 Apr 2006 13:52:18 -0700
From: Tony Jones <tonyj@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 1/11] security: AppArmor - Integrate into kbuild
Message-ID: <20060419205218.GA3513@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174913.29149.55209.sendpatchset@ermintrude.int.wirex.com> <20060419195502.GE25047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419195502.GE25047@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 09:55:02PM +0200, Adrian Bunk wrote:
> On Wed, Apr 19, 2006 at 10:49:13AM -0700, Tony Jones wrote:
> >...
> > --- /dev/null
> > +++ linux-2.6.17-rc1/security/apparmor/Kconfig
> > @@ -0,0 +1,9 @@
> > +config SECURITY_APPARMOR
> > +	tristate "AppArmor support"
> > +	depends on SECURITY!=n
> >...
> 
> Are you _really_ sure SECURITY=m, SECURITY_APPARMOR=y is a valid 
> configuration?

Thanks Adrian. Others made the exact same point.  My bad.  Fixed already.

Thanks
