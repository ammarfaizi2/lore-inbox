Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265052AbUETKfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbUETKfE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 06:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265066AbUETKfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 06:35:04 -0400
Received: from vogsphere.datenknoten.de ([212.12.48.49]:22914 "EHLO
	vogsphere.datenknoten.de") by vger.kernel.org with ESMTP
	id S265052AbUETKe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 06:34:58 -0400
Subject: Re: Strange DMA-errors and system hang with SMART (was: ...and
	system hang with Promise 20268)
From: Sebastian <sebastian@expires0604.datenknoten.de>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0405200422280.24137-100000@dirac.phys.uwm.edu>
References: <Pine.GSO.4.21.0405200422280.24137-100000@dirac.phys.uwm.edu>
Content-Type: text/plain
Message-Id: <1085049301.4485.18.camel@coruscant.datenknoten.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 12:35:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 20.05.2004 schrieb Bruce Allen um 11:23:
> Sebastian, does the disk's SMART error log (smartctl -l error) give any
> indication of what's wrong?

Hi Bruce,

no, no errors were logged. However, and that was the reason why I
initially saw a connection to the old thread from March 2004 that talked
about SMART tests correlated with these DMA errors:

SMART Self-test log 
# 1  Short offline       Interrupted (host reset)      10%     
#10  Short offline       Interrupted (host reset)      10%     
#15  Short offline       Interrupted (host reset)      10%     

Thus, short offline self-tests were running at the times where the DMA
errors and system hangs occurred.

Further, there seems to be a known problem with SMART related to the
hard drive that I am using:

Device Model:     IC35L040AVER07-0

However, I had been running SMART self-tests without any problems until
that kernel upgrade.

I already turned off SMART self-tests - no crashes so far, but too early
to be sure. Maybe it is just a hard drive problem that did not show up
before. Since I had planned to replace that disk drive anyhow, I will do
that sooner.

Thanks,

Sebastian


