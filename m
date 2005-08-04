Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVHDHtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVHDHtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 03:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVHDHtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 03:49:31 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:8850 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261943AbVHDHta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 03:49:30 -0400
Date: Thu, 4 Aug 2005 13:20:13 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: opening linux char device file in user thread.
Message-ID: <Pine.LNX.4.60.0508041317360.5451@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hai,

    I have written a daemon which is running in user space, will send some 
data periodically to kernel space. This I have done with the help of a 
device file.

  It is working, but I want to apply threads mechanism in that daemon. But 
when I split that daemon functionality into a thread and a original 
process. I am unable to 
open the device file. This is happening in both places(either in thread or 
original process).

The device is opening  when threading is not there.

Can anybody suggest me?

Regards,
P.Manohar.

