Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTKUVBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 16:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbTKUVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 16:01:16 -0500
Received: from waste.org ([209.173.204.2]:12162 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263106AbTKUVBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 16:01:15 -0500
Date: Fri, 21 Nov 2003 15:01:08 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm5
Message-ID: <20031121210108.GJ22139@waste.org>
References: <20031121121116.61db0160.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031121121116.61db0160.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 21, 2003 at 12:11:16PM -0800, Andrew Morton wrote:
> 
> +4g4g-athlon-triplefault-fix.patch
> 
>  Fix triplefaults when starting X on athlons with the 4G/4G plit enabled.

For the record, Zwane and I reproduced this on K6, Opteron, P4, and
Xeon. In fact, the one machine I couldn't trigger the bug on was an
Athlon.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
