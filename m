Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbUAHR0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUAHR0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:26:25 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:59350 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265501AbUAHR0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:26:19 -0500
Subject: Re: x86_64 + 2.6.1-rc3 panics on aic79xx
From: James Bottomley <James.Bottomley@steeleye.com>
To: Berkley Shands <berkley@cs.wustl.edu>
Cc: gibbs@scsiguy.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, pbadari@us.ibm.com
In-Reply-To: <200401081627.i08GRgZ0000027670@mudpuddle.cs.wustl.edu>
References: <200401081627.i08GRgZ0000027670@mudpuddle.cs.wustl.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Jan 2004 12:26:07 -0500
Message-Id: <1073582767.2741.14.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-08 at 11:27, Berkley Shands wrote:
> 	A pure stock 2.6.1-rc3 kernel also bug halts with sg corruption
> on the first scsi retry. It seems that the iommu has serious issues
> with all three variants of  current kernel patches.

Andi Kleen has produced a patch for the sg list problems.  Could you see
if you can reproduce the issues when Andi produces a patch kit for
x86_64 and -rc3, so we're not trying to debug non-scsi issues?

Thanks,

James


