Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWJDVCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWJDVCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWJDVCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:02:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:64403 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751126AbWJDVCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:02:15 -0400
Subject: Re: 2.6.18-mm3 oops in xfrm_register_mode
From: Steve Fox <drfickle@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20061004095703.5c843514.akpm@osdl.org>
References: <20061003001115.e898b8cb.akpm@osdl.org>
	 <4523CFEF.6000007@us.ibm.com>  <20061004095703.5c843514.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 16:02:11 -0500
Message-Id: <1159995731.28106.82.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 09:57 -0700, Andrew Morton wrote:

> You might well find this bisection lands you on origin.patch.  ie: a
> mainline bug.  I note that David merged a few more xfrm fixes this morning.
> 
> So to confirm that, first test just origin.patch and if that fails, test
> git-of-the-moment.  If that doesn't fail, they fixed it.

origin.patch from --m3 failed. Unfortunately so did a fresh clone of
Linus's git tree.

-- 

Steve Fox
IBM Linux Technology Center
