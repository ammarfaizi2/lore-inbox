Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160995AbWJKSrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbWJKSrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWJKSrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:47:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18891 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1160995AbWJKSrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:47:22 -0400
Subject: Re: it821x eats CPU?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Heinz Ulrich Stille <hus@design-d.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200610070927.13713.hus@design-d.de>
References: <200610070927.13713.hus@design-d.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Oct 2006 20:13:41 +0100
Message-Id: <1160594021.16513.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-07 am 09:27 +0200, ysgrifennodd Heinz Ulrich Stille:
> Looking through the logs I notices that it821x was in "smart" mode,
> so I restarted the system with "noraid=1" to get into "pass through".
> Now everything is back to normal. A large dd did about 40MB/s without
> disturbing other processes.

In some configurations the it821x driver was not enabling DMA in smart
mode.

> Wasn't smart mode the one supposed to be the one reducing CPU load?

For RAID1 yes, otherwise not measurably at all.


