Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266082AbUAFGrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 01:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbUAFGrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 01:47:35 -0500
Received: from web10303.mail.yahoo.com ([216.136.130.81]:55477 "HELO
	web10303.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266082AbUAFGrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 01:47:33 -0500
Message-ID: <20040106064732.34104.qmail@web10303.mail.yahoo.com>
Date: Mon, 5 Jan 2004 22:47:32 -0800 (PST)
From: sundarapandian durairaj <sundar_draj@yahoo.com>
Subject: PCI resource allocation problem in Enterprise Linux 3.0
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am having some PCI resource allocation problem in RH
Enterprise Linux 3.0 (linux-2.4.21-4.EL kernel).

Its seems the kernel is not allocating  PCI resource
for our PCI card during kernel init. This  PCI
resource allocation problem has been occurred only in
RHEL 3.0 kernel.

When I am testing our card in RH 9.0 (2.4-20) kernel,
I can see all PCI resource regions like memio and
ioport regions are allocated properly. (I am using
/proc/iomem and /proc/ioport for this). So I 
am suspecting  RHEL 3.0 kernel is not populating the
PCI resources properly during kernel initialization. 

Am I missing some thing in kernel configuration while
kernel image building. 

Any help regarding this will be greatly appreciated.

Thanks,
Sundar


__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
