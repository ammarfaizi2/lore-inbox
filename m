Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVCJT7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVCJT7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVCJT7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:59:34 -0500
Received: from waste.org ([216.27.176.166]:9708 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263030AbVCJTg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:36:28 -0500
Date: Thu, 10 Mar 2005 11:36:11 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] silence sort(..., swap) warning on ia64
Message-ID: <20050310193611.GL3120@waste.org>
References: <20050310181835.GA8348@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310181835.GA8348@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 10:18:35AM -0800, Chris Wedgwood wrote:
> Not tested but seems plausible :-)

Yep, this was pointed out to me yesterday.
  
> -static void swap_ex(void *a, void *b)
> +static void swap_ex(void *a, void *b, int _unused_size)

-- 
Mathematics is the supreme nostalgia of our time.
