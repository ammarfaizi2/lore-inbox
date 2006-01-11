Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWAKSpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWAKSpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWAKSpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:45:40 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:28070 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932539AbWAKSpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:45:30 -0500
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
From: Dave Hansen <haveblue@us.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
In-Reply-To: <43C53DA0.60704@us.ibm.com>
References: <43C53DA0.60704@us.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 10:45:26 -0800
Message-Id: <1137005126.27584.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 12:17 -0500, Mike D. Day wrote:
> +#ifndef BOOL
> +#define BOOL    int
> +#endif
> +
> +#ifndef FALSE
> +#define FALSE   0
> +#endif
> +
> +#ifndef TRUE
> +#define TRUE    1
> +#endif
> +
> +#ifndef NULL
> +#define NULL    0
> +#endif

Whatever you do with this driver, these need to go.

Your patch is also whitespace-challenged.

Why not make these Xen attributes part of the "system" devices?  Seems a
lot more natural to me.

-- Dave

