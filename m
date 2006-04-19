Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWDSTzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWDSTzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWDSTzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:55:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19972 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751219AbWDSTzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:55:03 -0400
Date: Wed, 19 Apr 2006 21:55:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 1/11] security: AppArmor - Integrate into kbuild
Message-ID: <20060419195502.GE25047@stusta.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174913.29149.55209.sendpatchset@ermintrude.int.wirex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419174913.29149.55209.sendpatchset@ermintrude.int.wirex.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 10:49:13AM -0700, Tony Jones wrote:
>...
> --- /dev/null
> +++ linux-2.6.17-rc1/security/apparmor/Kconfig
> @@ -0,0 +1,9 @@
> +config SECURITY_APPARMOR
> +	tristate "AppArmor support"
> +	depends on SECURITY!=n
>...

Are you _really_ sure SECURITY=m, SECURITY_APPARMOR=y is a valid 
configuration?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

