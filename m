Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWIPR7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWIPR7S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWIPR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 13:59:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:29303 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964871AbWIPR7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 13:59:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=BqnOB6/9IpDbRE5sMQfxdjwcPDOPSh+8TF/ZBzK5o5ABcSumjeWpUMDfnOC3+8KKUcsKSYv/L4aXi7FfZVBQ9xZpDY0MYrb1XA9vyPFCCacwQRDy87I2nTSFUUouh1SDqDONMqPpI/QdRJLGcNqj+DbpiiEdjYndIYE2kcCEx+I=
Message-ID: <450C3B95.7060808@gmail.com>
Date: Sat, 16 Sep 2006 11:59:49 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: schedule check_region for removal ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


its apparently been deprecated for a long time
http://lkml.org/lkml/2003/6/12/100

But its still used, notably in drivers/scsi/BusLogic.c

And jumping the gun a bit, theres a number of "got rid of check_region" 
comments,
which now belong in the changelog. Do these also get deleted ?
