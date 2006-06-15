Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030735AbWFOP4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbWFOP4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWFOP4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:56:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:6861 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030735AbWFOP4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:56:35 -0400
Date: Thu, 15 Jun 2006 08:56:11 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: frode isaksen <frode.isaksen@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: sys_poll with timeout -1 bug fix
Message-ID: <20060615155611.GO11131@us.ibm.com>
References: <383D1CA3-E74C-4530-A8C8-D0B9608A1970@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383D1CA3-E74C-4530-A8C8-D0B9608A1970@gmail.com>
X-Operating-System: Linux 2.6.17-rc6 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2006 [17:33:05 +0200], frode isaksen wrote:
> From: Frode Isaksen <frode.isaksen@gmail.com>
> 
> If you do a poll() call with timeout -1, the wait will be a big  
> number (depending on HZ)  instead of infinite wait, since -1 is  
> passed to the msecs_to_jiffies function.
> 
> Signed-off-by: Frode Isaksen <frode.isaksen@gmail.com>
Acked-by: Nishanth Aravamudan <nacc@us.ibm.com>

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
