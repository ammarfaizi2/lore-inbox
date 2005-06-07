Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVFGRuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVFGRuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 13:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVFGRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 13:50:09 -0400
Received: from fmr23.intel.com ([143.183.121.15]:8594 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261942AbVFGRuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 13:50:05 -0400
Date: Tue, 7 Jun 2005 10:50:02 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pentium-D support
Message-ID: <20050607105001.A27234@unix-os.sc.intel.com>
References: <42A5B80A.4040709@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42A5B80A.4040709@tmr.com>; from davidsen@tmr.com on Tue, Jun 07, 2005 at 11:06:50AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 11:06:50AM -0400, Bill Davidsen wrote:
> Is there any reason to think that 
> the scheduler would get confused by the CPU, such as thinking it was HT 
> or some such?

2.6.12-rc5 has the Intel dual core detection patches. With those, kernel
can distinguish between cores and HT logical siblings.

thanks,
suresh
