Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbULWHIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbULWHIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 02:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbULWHIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 02:08:06 -0500
Received: from holomorphy.com ([207.189.100.168]:2485 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261170AbULWHIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 02:08:05 -0500
Date: Wed, 22 Dec 2004 23:07:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paramveer Singh <kernel.mail@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 opteron 32 Gig RAM has 10k block writes/sec on running posgresql 7.4.6 disk i/o intensive app
Message-ID: <20041223070757.GZ771@holomorphy.com>
References: <11f564b9041222225638905557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f564b9041222225638905557@mail.gmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 12:26:48PM +0530, Paramveer Singh wrote:
> we are using a RedHat AS3 U3 box (2.4.21-4.ELsmp) to run a very
> intensive database app which does a _huge_ number of inserts durnig
> the data generation phase. However, we are noticing a unexpected
> performance drops with user cpu utilization numbers falling to near 0.
> most of the cpu is used up in iowait. 
> CPU states:  cpu    user    nice  system    irq  softirq  iowait    idle
>           total    2.0%    0.0%    7.6%   0.0%     0.0%  362.4%   27.2%
> /proc/slabinfo showed huge numbers in buffer_head. The line was:
> buffer_head       4908452 4962249    200 260854 261171    1 : 16000 4000

Please try to reproduce on a more recent RHEL3, e.g. RHEL3-U4 released
today.


-- wli
