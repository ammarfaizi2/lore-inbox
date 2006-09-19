Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWISWfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWISWfK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWISWfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:35:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33226 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751351AbWISWfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:35:05 -0400
Date: Tue, 19 Sep 2006 21:04:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [PATCH 5/7] SLIM: make and config stuff
Message-ID: <20060919190423.GB7210@elf.ucw.cz>
References: <1158083876.18137.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158083876.18137.15.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch contains the Makefile, Kconfig and .h files for SLIM.

> +config SECURITY_SLIM_BOOTPARAM_VALUE
> +	int "SLIM boot parameter default value"
> +	depends on SECURITY_SLIM_BOOTPARAM
> +	range 0 1
> +	default 1
> +	help
> +	  This option sets the default value for the kernel parameter
> +	  'slim', which allows SLIM to be disabled at boot.  If this
> +	  option is set to 0 (zero), the SLIM kernel parameter will
> +	  default to 0, disabling SLIM at bootup.  If this option is
> +	  set to 1 (one), the SLIM kernel parameter will default to 1,
> +	  enabling SLIM at bootup.
> +
> +	  If you are unsure how to answer this question, answer 1.
> +

Do we really need this option? Seems like anyone wanting slim can just
pass the boot argument...?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
