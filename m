Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032032AbWLGLFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032032AbWLGLFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032033AbWLGLFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:05:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46918 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032032AbWLGLFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:05:12 -0500
Date: Thu, 7 Dec 2006 11:07:37 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Bob <spam@homeurl.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 SMP very slow with ServerWorks LE Chipset
Message-ID: <20061207110737.6c506c98@localhost.localdomain>
In-Reply-To: <4577AA11.6020906@homeurl.co.uk>
References: <4577AA11.6020906@homeurl.co.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As a test of raw CPU power I've been decompressing the kernel tree, with 
> a UP 2.6 kernel this takes about 1m 15s, I don't know if bz2 is 
> multithreaded but even if it's not I would expect a slight speed increase 
> but in fact with a SMP 2.6 kernel it take 13 ~ 26m, with a SMP 2.4 
> kernel it takes 1m 28s and with a 2.4 UP 1m 35s. 

The 2.4 numbers look correct (slightly slower), the 2.6 numbers do not.


Nothing obviously wrong from the traces however. If you pin the bzip to a
given processor do you get different results according to which CPU ?

(see man taskset for info on the commands)

If you get very different times on the two processors that will be very
useful information.
