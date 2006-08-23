Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWHWRfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWHWRfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 13:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWHWRfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 13:35:25 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:20496 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S932262AbWHWRfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 13:35:25 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: ppc prep boot failure in 2.6.18-rc3
In-Reply-To: <Pine.SOC.4.61.0608012106350.3786@math.ut.ee>
User-Agent: tin/1.9.2-20060621 ("Benmore") (UNIX) (Linux/2.6.18-rc4 (i686))
Message-Id: <20060823173515.E0A1B14063@rhn.tartu-labor>
Date: Wed, 23 Aug 2006 20:35:15 +0300 (EEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MR> I tried yesterdays 2.6.18-rc3+git snapshot on a ppc prep machine 
MR> (Motorola Powerstack II). While 2.6.17 worked fine (modulo patched 
MR> x_tables alignment), this kernel does not even boot:
MR> 
MR> Uncompressing Linux... inflate returned FFFFFFFE
MR> exit

For archival: this was a false alarm - it was caused by a hardware
problem that was solved by reseating the cache SIMM.

-- 
Meelis Roos
