Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266414AbUBLNp1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 08:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266428AbUBLNp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 08:45:27 -0500
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:11953 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S266414AbUBLNpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 08:45:20 -0500
Reply-To: <grant@reflection-computer-services.co.uk>
From: "Grant Fribbens" <grant@reflection-computer-services.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.2 VFS unable to mount root fs
Date: Thu, 12 Feb 2004 13:42:38 -0000
Message-ID: <005701c3f16e$506886f0$0200a8c0@heron>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have been running successfully the 2.6.x series of kernel up until the
release of 2.6.2 on my Dell Latitude C600 notebook with the Fedora Core 1
distribution and updated with the latest module-init-tools. I can still boot
into 2.6.1 and 2.4.25 fine but when 2.6.2 comes up I get the following:-

VFS: Cannot open root device "hda6" or unknown-block(0,0)
Please append a correct "root=" boot option

my grub command line is as follows:-

root=/dev/hda6 initrd=/boot/initrd-2.6.2.img rhgb

I did find there to be a similar issue with 2.6.0-test1-mm1 kernel which
someone suggested putting the actual minor major number in the root option
as shown below:-

root=0306 initrd=/boot/initrd-2.6.2.img rhgb

and I still cannot boot. I have tried the 2.6.3-rc1 and 2.6.3-rc2 releases
and get the same problem.

Is anyone else experiencing a similar problem or have a solution?

Regards

Grant Fribbens

