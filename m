Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbUCHMTN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 07:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUCHMTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 07:19:13 -0500
Received: from zero.aec.at ([193.170.194.10]:48901 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262465AbUCHMTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 07:19:12 -0500
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hyper-threaded pickle
References: <1wfBD-6GI-9@gated-at.bofh.it> <1whjQ-8sH-25@gated-at.bofh.it>
	<1wMeo-Sr-3@gated-at.bofh.it> <1xlbI-6Rl-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 14 Mar 2004 04:35:09 +0100
In-Reply-To: <1xlbI-6Rl-5@gated-at.bofh.it> (Len Brown's message of "Mon, 08
 Mar 2004 06:10:10 +0100")
Message-ID: <m3wu5o9k42.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> writes:

>> > Re: old systems -- we use dmi_scan to disable ACPI on systems by default
>> > on systems older than 1/1/2001.
>> 
>> What happens for the no-DMI case?
>
> When DMI is not present, dmi_scan is a no-op -- so ACPI will run in

A box without DMI likely also doesn't have ACPI tables. I believe DMI
is older than ACPI.

-Andi

