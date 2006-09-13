Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWIMTJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWIMTJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWIMTJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:09:46 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:43427 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1751119AbWIMTJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:09:44 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=mLAygi6hZJ8xvy29UwvvohVvhVx7N5Id1C7rpfZhLj64RLxcerRzAxddOMNo1ML9d2F2Lm9QHQ8gH3UREXftqzRlm0BBDBEsPkJvrJ1bcsb0oz+NXorgKKWyhGBwq+1d;
X-IronPort-AV: i="4.09,160,1157346000"; 
   d="scan'208"; a="79494379:sNHT15239061"
Date: Wed, 13 Sep 2006 14:09:38 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IPMI: fix handling of OEM flags
Message-ID: <20060913190937.GA9264@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <20060913185012.GA13036@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060913185012.GA13036@localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 01:50:12PM -0500, Corey Minyard wrote:
> 
> If one of the OEM flags becomes set in the flags from the
> hardware, the driver could hang if no OEM handler was set.
> Fix the code to handle this.  This was tested by setting
> the flags by hand after they were fetched.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>

Acked-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
