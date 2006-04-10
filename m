Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWDJAhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWDJAhb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 20:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWDJAhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 20:37:31 -0400
Received: from mail.renesas.com ([202.234.163.13]:41876 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1750832AbWDJAha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 20:37:30 -0400
Date: Mon, 10 Apr 2006 09:37:26 +0900 (JST)
Message-Id: <20060410.093726.831841882.takata.hirokazu@renesas.com>
To: akpm@osdl.org
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org,
       fujiwara@linux-m32r.org
Subject: Re: [PATCH 2.6.17-rc1-mm1] m32r: Fix cpu_possible_map and
 cpu_present_map initialization for SMP kernel
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060407150337.7cc0c462.akpm@osdl.org>
References: <20060407.194745.233672521.takata.hirokazu@renesas.com>
	<20060407150337.7cc0c462.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Fri, 07 Apr 2006 15:03:37 -0700
> Hirokazu Takata <takata@linux-m32r.org> wrote:
> >
> > This patch fixes a boot problem of the m32r SMP kernel
> > 2.6.16-rc1-mm3 or later.
> 
> This sounds like something which needs to be backported into 2.6.16.x,
> correct?
> 
> Also, should "m32r: security fix of {get,put}_user macros" go into 2.6.16.x?

Yes, please include this into 2.6.16.x.

Thanks,

-- Takata
