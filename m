Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965299AbWGJWsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbWGJWsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965305AbWGJWsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:48:04 -0400
Received: from xenotime.net ([66.160.160.81]:21151 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965303AbWGJWsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:48:03 -0400
Date: Mon, 10 Jul 2006 15:50:51 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Document that sys_sysctl will be removed.
Message-Id: <20060710155051.326e49da.rdunlap@xenotime.net>
In-Reply-To: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com>
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 16:39:47 -0600 Eric W. Biederman wrote:

> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  Documentation/feature-removal-schedule.txt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index e978943..bef1bf0 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -250,3 +250,14 @@ Why:	These drivers never compiled since 
>  Who:	Jean Delvare <khali@linux-fr.org>
>  
>  ---------------------------
> +
> +What:	sys_sysctl
> +When:	January 2007
> +Why:	The same information is available through /proc/sys and that is the
> +	interface user space prefers to use. And there do not appear to be
> +	any existing user in user space of sys_sysctl.  The additional
> +	maintenance overhead of keeping a set of binary names gets
> +	in the way of doing a good job of maintaining this interface.
> +
> +Who:	Eric Biederman <ebiederm@xmission.com>


aha, patch 1/2 and patch 2/2 would have helped that.  :)

---
~Randy
