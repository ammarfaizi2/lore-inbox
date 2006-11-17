Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755648AbWKQKNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbWKQKNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 05:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbWKQKNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 05:13:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:57312 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755648AbWKQKNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 05:13:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=GTwrHHId1PKomHdpSFYxWevoouJR0uETZtX0zsMf6Rk/9lgjOB4FFedbe28PYN99LdvNYP7Z1Koe+qewj6vEp11FRE+Sbz3b971Jz7mY/7FfP4IIm5wFNFJRdaT5BlZ5gLRGzGhHIeL/OJK8e1jDJ5ZhYvSg3WYTcLrZszycLxM=
Message-ID: <455D8B44.2060600@gmail.com>
Date: Fri, 17 Nov 2006 19:13:24 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: regarding VIA quirk fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alan.

We've been getting bug reports from sata_via users for quite sometime 
now.  The first IRQ driven command (IDENTIFY) times out and thus device 
detection fails.  The following patch seems to fix it for many users.

http://marc.theaimsgroup.com/?l=linux-kernel&m=116300291505638

But, not for all.

http://bugzilla.kernel.org/show_bug.cgi?id=7415

Any ideas how to proceed on this bug?

Thanks.

-- 
tejun
