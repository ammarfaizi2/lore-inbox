Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWHWTSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWHWTSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWHWTSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:18:13 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:65239 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S965128AbWHWTSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:18:11 -0400
Subject: Re: [PATCH 5/7] SLIM: make and config stuff
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1156359949.6720.69.camel@localhost.localdomain>
References: <1156359949.6720.69.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 23 Aug 2006 15:19:33 -0400
Message-Id: <1156360773.8506.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 12:05 -0700, Kylene Jo Hall wrote:
> This patch contains the Makefile, Kconfig and .h files for SLIM.
> 
> Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>

> --- linux-2.6.18-rc3/security/slim/Kconfig	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.18-rc3-working/security/slim/Kconfig	2006-08-04 13:29:13.000000000 -0500
> @@ -0,0 +1,6 @@
> +config SECURITY_SLIM
> +	boolean "SLIM support"
> +	depends on SECURITY && SECURITY_NETWORK && INTEGRITY

&& !SECURITY_SELINUX?

> +	help
> +	  The Simple Linux Integrity Module implements a modified low water-mark
> +	  mandatory access control integrity model.

-- 
Stephen Smalley
National Security Agency

