Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUHECGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUHECGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUHECGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:06:37 -0400
Received: from zero.aec.at ([193.170.194.10]:13060 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264577AbUHECGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:06:36 -0400
To: Phy Prabab <phyprabab@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Issues with MPT scsi driver
References: <2pFoG-4kS-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 05 Aug 2004 04:06:32 +0200
In-Reply-To: <2pFoG-4kS-9@gated-at.bofh.it> (Phy Prabab's message of "Thu,
 05 Aug 2004 03:40:06 +0200")
Message-ID: <m3llguxrrr.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy Prabab <phyprabab@yahoo.com> writes:

> Hello all.
>
> I am having issues with MTP driver under 2.6.8(rcx) on
> Opteron.  Also under stock 2.6.7, however 2.6.7-bk20
> appears to be the last to be functional.

It works for me as of 2.6.8rc2. 

> The kernel boots but fails on the MPT (my main drive)
> to pivot_root (perpetual "Reset").  

Tried pci=noacpi? Maybe it is an ACPI problem.

> Anyone have any luck with this driver?

Yes, it works fine on a lot of machines - MPT Fusion
is one of the most common SCSI controllers on Opteron
boards.

-Andi

