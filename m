Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWGDALE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWGDALE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWGDALE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:11:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750950AbWGDALC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:11:02 -0400
Date: Mon, 3 Jul 2006 17:10:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Straub, Michael" <Michael.Straub@avocent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 7/13] Equinox SST driver: driver structures
Message-Id: <20060703171059.39ec86b9.akpm@osdl.org>
In-Reply-To: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110B@sun-email.corp.avocent.com>
References: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110B@sun-email.corp.avocent.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:17:48 -0400
"Straub, Michael" <Michael.Straub@avocent.com> wrote:

> +#ifndef MIN
> +#define MIN(a,b)	(((a) < (b)) ? (a) : (b))
> +#endif
> +#ifndef MAX
> +#define MAX(a,b)	(((a) > (b)) ? (a) : (b))
> +#endif

These should be removed - use min() and max() from <linux/kernel.h>
