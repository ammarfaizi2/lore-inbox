Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758899AbWK2WkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758899AbWK2WkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758900AbWK2WkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:40:10 -0500
Received: from main.gmane.org ([80.91.229.2]:12748 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1758899AbWK2WkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:40:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bart Trojanowski <bart@jukie.net>
Subject: Re: 2.6.18.3 SMP PREEMPT crashes (x86-64)
Date: Wed, 29 Nov 2006 21:07:26 +0000 (UTC)
Message-ID: <loom.20061129T220542-977@post.gmane.org>
References: <20061129170253.GH2418@jukie.net> <200611291812.08408.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 74.104.68.19 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061115 Ubuntu/dapper-security Firefox/1.5.0.8)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor <prakash <at> punnoor.de> writes:
> Does your bios have the option to enable the hpet? (Maybe after a bios 
> update?)

It does not.

> If not:
> 
> Try booting with noapic, compile latest git kernel and buut it (w/o noapic). 
> Above message should now not appear, if I am not mistaken. Otherwise you have 
> to hack the kernel to not ignoge the timer override..

Worked as advertised.  I booted with noapic maxcpus=1 and rebuilt the git repo.
 Rebooted and ran through the same kind of stress tests.  Seems to work.

Thanks a lot.



