Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUCZOKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUCZOKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:10:39 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:5769 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S261915AbUCZOKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:10:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16484.14768.799819.150203@gargle.gargle.HOWL>
Date: Fri, 26 Mar 2004 09:09:52 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large memory application exhuasts buffers during write.
In-Reply-To: <20040326012056.GB19152@lnx-holt>
References: <20040326012056.GB19152@lnx-holt>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Robin> What we see happen is the first approx 30GBs gets written and then
Robin> swap starts getting utilized.  Once swap has been heavily utilized,
Robin> the OOM killer kicks in and kills the job.

Can you post the output of 'vmstat 1' starting just before your app is
fired up, and until OOM kicks in an kills it off?   And more details
on exactly which version of Linux kernel you're running and how the
system is configured as well.

John
