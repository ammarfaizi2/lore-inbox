Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVE1QRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVE1QRY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 12:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVE1QRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 12:17:23 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57793 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261160AbVE1QRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 12:17:12 -0400
Subject: Re: How to find if BIOS has already enabled the device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: John Livingston <jujutama@comcast.net>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200505281018.18092.kernel-stuff@comcast.net>
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com>
	 <200505280957.46853.kernel-stuff@comcast.net>
	 <1117289090.2390.14.camel@localhost.localdomain>
	 <200505281018.18092.kernel-stuff@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117296905.2356.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 May 2005 17:15:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-05-28 at 15:18, Parag Warudkar wrote:
> dmesg is perfectly normal, not even timestamp differences before and after 
> call to pci_enable_device - since the machine is completely hung for that 
> period - not even the clock is ticking?

A spurious jammed IRQ is one candidate - but you haven't provided dmesg
data

