Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264979AbUD2Vg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbUD2Vg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264970AbUD2VeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:34:13 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:38161 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264874AbUD2Vdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:33:49 -0400
Message-ID: <409175CF.9040608@techsource.com>
Date: Thu, 29 Apr 2004 17:38:23 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, nickpiggin@yahoo.com.au,
       jgarzik@pobox.com, akpm@osdl.org, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au>	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl> <20040429133613.791f9f9b.pj@sgi.com>
In-Reply-To: <20040429133613.791f9f9b.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Jackson wrote:

> Heh - indeed perhaps the answer is closer than I realize.  For SGI's big
> NUMA boxes, managing memory placement is sufficiently critical that we
> are inventing or encouraging ways (such as Andi Kleen's numa stuff) to
> control memory placement per node per job.  Perhaps this needs to be
> extended to portions of a node (this job can only use 1 Gb of the memory
> on that 2 Gb node) and to other memory uses (file cache, not just user
> space memory).
> 

Is updatedb run with a nice level greater than zero?

Perhaps nice level could influence how much a process is allowed to 
affect page cache.

