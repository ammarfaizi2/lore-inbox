Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWHYCcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWHYCcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 22:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWHYCcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 22:32:46 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55198 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751394AbWHYCcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 22:32:45 -0400
Message-ID: <44EE6149.7000404@garzik.org>
Date: Thu, 24 Aug 2006 22:32:41 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA 150 vs SATA 300
References: <44EDBD0C.9040501@perkel.com>
In-Reply-To: <44EDBD0C.9040501@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> Another speed related question. How much faster are SATA II drives 
> compared to regular SATA drives in real life? And - does NCQ really 
> help? I'm just looking for a general guess in the form of, "The Disk IO 
> upgrading to SATA II with NCQ will generally be X% faster." What value 
> is X?

SATA 150 and SATA 300 refers to interface speed (1.5Gbps or 3Gbps). 
Unless its entirely flash-based or RAM-based, it is highly unlikely that 
your disk max out the SATA cable bandwidth.

There is "SATA II is x times faster" rule, because it depends on the 
drive mechanics inside.  A SATA II drive may be exactly the same speed 
as SATA I, except that it is upgraded to support NCQ and other SATA II 
features.

NCQ definitely helps.

	Jeff



