Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVKUFuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVKUFuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 00:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVKUFuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 00:50:51 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:64736 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932196AbVKUFuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 00:50:50 -0500
Message-ID: <43816038.9050700@us.ibm.com>
Date: Sun, 20 Nov 2005 21:50:48 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/8] Create Critical Page Pool
References: <437E2C69.4000708@us.ibm.com>	<437E2D23.10109@us.ibm.com> <20051118160855.1ea249c8.pj@sgi.com>
In-Reply-To: <20051118160855.1ea249c8.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Total nit:
> 
>  #define __GFP_HARDWALL   ((__force gfp_t)0x40000u) /* Enforce hardwall cpuset memory allocs */
> +#define __GFP_CRITICAL	((__force gfp_t)0x80000u) /* Critical allocation. MUST succeed! */
> 
> Looks like you used a space instead of a tab.

It's a tab on my side...  Maybe some whitespace munging by Thunderbird?
Will make sure it's definitely a tab on the next itteration.

-Matt
