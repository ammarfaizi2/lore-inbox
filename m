Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWCVWOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWCVWOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWCVWOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:14:39 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17901
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751302AbWCVWOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:14:14 -0500
Date: Wed, 22 Mar 2006 14:13:00 -0800 (PST)
Message-Id: <20060322.141300.62168729.davem@davemloft.net>
To: mrustad@mac.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16 hugetlbfs problem
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <BE2452EA-2566-4C2A-B07D-BD63404A42C1@mac.com>
References: <BE2452EA-2566-4C2A-B07D-BD63404A42C1@mac.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rustad <mrustad@mac.com>
Date: Wed, 22 Mar 2006 16:10:33 -0600

> I seem to be having trouble using hugetlbfs with kernel 2.6.16. I  
> have a small test program that worked with 2.6.16-rc5, but fails with  
> 2.6.16-rc6 or the release. The program is below. Given a path to a  
> file on a hugetlbfs, it opens/creates the file, mmaps it and tries to  
> access the first word. On 2.6.16-rc5, it works. On 2.6.16, it hangs  
> page-faulting until it is killed.

On what platform?  Things like hugetlb and address space layout
(you're requesting a specific mmap() address I noticed) are very
platform specific.
