Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbVJEV2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVJEV2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbVJEV2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:28:36 -0400
Received: from farad.aurel32.net ([82.232.2.251]:4803 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S1030383AbVJEV2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:28:35 -0400
Date: Wed, 5 Oct 2005 23:28:34 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc3] sis190.c: fix multicast MAC filter
Message-ID: <20051005212834.GA18781@bode.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	linux-kernel@vger.kernel.org
References: <20051005203350.GA3096@farad.aurel32.net> <20051005210552.GA18923@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20051005210552.GA18923@electric-eye.fr.zoreil.com>
X-Mailer: Mutt 1.5.11 (2005-09-15)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 11:05:52PM +0200, Francois Romieu wrote:
> Aurelien Jarno <aurelien@aurel32.net> :
> > Here is a patch that changes the way the MAC filter is computed for the
> > multicast addresses. The computation is taken from the SiS GPL driver. 
> 
> Ok.
> 
> [...]
> > This patch is necessary to get IPv6 working.
> 
> May I assume that it has been tested on the usual k8s-mx ?

Yes, you're right.

> If so, feel free to forward to jgarzik@pobox.com and netdev@vger.kernel.org.
> I've just bought a mobo to test this adapter but it will not be ready before
> this week end.

Ok, will do that.

Thanks,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
