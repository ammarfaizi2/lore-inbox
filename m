Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVFIRAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVFIRAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVFIRAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:00:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:23739 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262412AbVFIQ7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:59:39 -0400
Date: Thu, 9 Jun 2005 09:59:28 -0700
From: Greg KH <greg@kroah.com>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 00/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050609165928.GE9597@kroah.com>
References: <42A8386F.2060100@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A8386F.2060100@jp.fujitsu.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 09:39:11PM +0900, Hidetoshi Seto wrote:
> Hi, long time no see :-D
> 
> This is a continuation of previous post quite a while ago:
> "[PATCH/RFC] I/O-check interface for driver's error handling"
> 
> Reflecting every comments, I brushed up my patch for generic part.
> So today I'll post it again, and also post "ia64 part", which
> surely implements ia64-arch specific error checking. I think
> latter will be a sample of basic implement for other arch.

Overall, the idea and implementation looks very nice.  I just had a few
comments on the code style and how you implemented the .h and .c files.
Good job.

thanks,

greg k-h
