Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWHRUqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWHRUqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWHRUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:46:42 -0400
Received: from xenotime.net ([66.160.160.81]:20909 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964777AbWHRUqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:46:42 -0400
Date: Fri, 18 Aug 2006 13:49:33 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 6/8] SLIM: make and config stuff
Message-Id: <20060818134933.846526eb.rdunlap@xenotime.net>
In-Reply-To: <1155844410.6788.60.camel@localhost.localdomain>
References: <1155844410.6788.60.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 12:53:30 -0700 Kylene Jo Hall wrote:

> This patch contains the Makefile, Kconfig and .h files for SLIM.
> 
> Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> ---
>  security/Kconfig       |    1
>  security/Makefile      |    1
>  security/slim/Kconfig  |    6 ++
>  security/slim/Makefile |    6 ++
>  security/slim/slim.h   |  102 +++++++++++++++++++++++++++++++++++++
> ++ 5 files changed, 116 insertions(+)
> 
> --- linux-2.6.18-rc3/security/slim/slim.h	1969-12-31
> 18:00:00.000000000 -0600 +++
> linux-2.6.18-rc3-working/security/slim/slim.h	2006-08-07
> 13:00:14.000000000 -0500 @@ -0,0 +1,102 @@ +/*
> + * slim.h - simple linux integrity module
> + *
> + * SLIM's specific model is:
> + *
> + *  All objects are labeled with exteded attributes to indicate:

extended

> + *      Integrity Access Class (IAC)
> + *      Secrecy Access Class (SAC)

---
~Randy
