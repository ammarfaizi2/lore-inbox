Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTIFCS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 22:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbTIFCS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 22:18:57 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:62619 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262738AbTIFCS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 22:18:56 -0400
Date: Sat, 6 Sep 2003 11:18:49 +0900
From: Tejun Huh <tejun@aratech.co.kr>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Tejun Huh <tejun@aratech.co.kr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide task_map_rq() preempt count imbalance
Message-ID: <20030906021849.GA2789@atj.dyndns.org>
References: <20030903055257.GA31635@atj.dyndns.org> <200309031753.04535.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309031753.04535.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 05:53:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> As Jens pointed out its not a proper fix.  Please try attached patch.
> 
> You are using PIO mode with "IDE taskfile IO" option enabled.
> Please also check if this preempt count bug happens with taskfile IO
> disabled (from quick look at the code it shouldn't but...).
> 
> Do you have any other IDE problems?
> Do multi-sector PIO transfers with taskfile IO work for you (hdparm -m)?

 Hello Bartlomiej,

 Sorry for late response.  Your patch works perfectly.  Disabling
taskfile doesn't hurt anything and multi-sector is turned on by
default(16) and seems OK.  Thanks.

-- 
tejun

