Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVIKSo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVIKSo0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVIKSo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:44:26 -0400
Received: from math.ut.ee ([193.40.36.2]:4092 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S965021AbVIKSo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:44:26 -0400
Date: Sun, 11 Sep 2005 21:44:19 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: matthieu castet <castet.matthieu@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH - Resend] PNPACPI: only parse device that have CRS method
In-Reply-To: <43246410.9000803@free.fr>
Message-ID: <Pine.SOC.4.61.0509112142400.23848@math.ut.ee>
References: <20050911165410.6383314168@rhn.tartu-labor> <43246410.9000803@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You could try
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111827568001255&w=2 if you 
> haven't yet tried it ?

No, tried it now. Had to hand-apply 2 chunks because of kmalloc changes 
but it was trivial and probably correct. It seems to find nothing bad:
pnp: building resource template
pnp: encoding resources
pnp: irq flags are correct
pnp: setting resources
pnp: _SRS worked correctly
pnp: Device 00:0a activated.

-- 
Meelis Roos (mroos@linux.ee)
