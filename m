Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSKZKS3>; Tue, 26 Nov 2002 05:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSKZKS3>; Tue, 26 Nov 2002 05:18:29 -0500
Received: from www.qskills.net ([212.204.70.2]:9146 "EHLO mail.qskills.net")
	by vger.kernel.org with ESMTP id <S261907AbSKZKS2>;
	Tue, 26 Nov 2002 05:18:28 -0500
Date: Tue, 26 Nov 2002 12:26:43 +0100
From: Richard Mueller <mueller@teamix.net>
X-Mailer: The Bat! (v1.61) Business
Reply-To: Richard Mueller <mueller@teamix.net>
Organization: Teamix GmbH
X-Priority: 3 (Normal)
Message-ID: <75355206580.20021126122643@teamix.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: [PROBLEM] D-Link DFE-580TX: Only 3 Ports working
In-Reply-To: <20021125201803.A830@jurassic.park.msu.ru>
References: <140282249663.20021125161149@teamix.net>
 <20021125201803.A830@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ivan,

Monday, November 25, 2002, 6:18:03 PM, you wrote:
IK> It's clear BIOS bug. All four controllers are sitting behind PCI-to-PCI
IK> bridge which blocks IO access to the ranges 0xb100-0xb3ff, 0xb500-0xb7ff,
IK> 0xb900-0xbbff and 0xbd00-0xbfff due to PCI_BRIDGE_CTL_NO_ISA mode.

IK> Does this patch help?
Yes. It works fine. Thanks for your help.
At the moment I am stress-testing the NIC and it seems to be very
fine. If not I will repost.

IK> --- linux/arch/i386/kernel/pci-i386.c~  Thu Nov 21 20:34:54 2002
IK> [PATCH]
Thanks a lot!
This kind of Tech-support can only be realized with open-source.

-- 
Best regards,
 Richard                            mailto:mueller@teamix.net

