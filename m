Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWFGBe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWFGBe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 21:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWFGBe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 21:34:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:22598 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750765AbWFGBez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 21:34:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V7yCudvgekVoEZVmEJBxkUE4TLAL4nR7sGFJ5wD995y5PwgGxLBHNCwo3ZYSKishePOjXrctflG60uYjFR+Md6qmj9xTv2WlXu840rtrqgNXXIuy0CMV5f3RIWh4A/zKc8mJTse4UwbYwsd13xWdjHdnrkKto2a9AlCdcyaRfl8=
Message-ID: <9e4733910606061834r2496d700o85ce87584b0b1691@mail.gmail.com>
Date: Tue, 6 Jun 2006 21:34:55 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: EDAC, unable to reserve PCI mem region
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know anything about how EDAC works, but this doesn't look
right. I would not have expected a PCI memory reservation to fail if
everything was set up right.

EDAC MC: Ver: 2.0.0 Jun  6 2006
EDAC i82875p: i82875p init one
PCI: Unable to reserve mem region #1:1000@fecf0000 for device 0000:00:06.0
EDAC MC0: Giving out device to "i82875p_edac" i82875p: PCI 0000:00:00.0

using 2.6.17-rc6

I don't have a device 0000:00:06.0 in /sys/bus/pci/devices either.
Shouldn't there be an entry there if I have this hardware?

Looks like my EDAC isn't functioning, I used have entries for it in sysfs.

-- 
Jon Smirl
jonsmirl@gmail.com
