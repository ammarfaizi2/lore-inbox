Return-Path: <linux-kernel-owner+w=401wt.eu-S1754454AbXACGSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbXACGSH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 01:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbXACGSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 01:18:07 -0500
Received: from hera.kernel.org ([140.211.167.34]:54620 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbXACGSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 01:18:05 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: g3vbv@blueyonder.co.uk
Subject: Re: 2.6.19 and up to 2.6.20-rc2 Ethernet problems x86_64
Date: Wed, 3 Jan 2007 01:17:31 -0500
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <459A7D46.5000509@blueyonder.co.uk> <200701021159.24945.lenb@kernel.org> <459AE34D.8040709@blueyonder.co.uk>
In-Reply-To: <459AE34D.8040709@blueyonder.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701030117.31737.lenb@kernel.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ..same problem with 2.6.20-rc3. Last worked with 
> 2.6.19-rc6-git12, so it was 2.6.19 where it failed.


> Attaching both case1 normal, case2 acpi=noirq. With acpi=noirq ethernet 
> doesn't get configured, route -n says it's an Unsupported operation, 
> ifconfig only shows for localhost, ifconfig eth0 192.168.10.5 also 
> complains of a config error.

It seems that the "acpi=noirq" (and probably also the acpi=off) case
is simply an additional broken case, not a success case to compare to.

The thing we really want to compare is dmesg and /proc/interrupts
from 2.6.19-rc6-git12, and the broken current release.
Perhaps you can put that info in the bug report when you file it.

thanks,
-Len

