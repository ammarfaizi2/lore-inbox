Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUJWKyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUJWKyC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUJWKyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:54:02 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:37327 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S266891AbUJWKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:54:00 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How is user space notified of CPU speed changes?
In-Reply-To: <1098508238.13176.17.camel@krustophenia.net>
References: <1098399709.4131.23.camel@krustophenia.net> <1098444170.19459.7.camel@localhost.localdomain> <1098444170.19459.7.camel@localhost.localdomain> <1098508238.13176.17.camel@krustophenia.net>
Date: Sat, 23 Oct 2004 11:53:54 +0100
Message-Id: <E1CLJX0-0001wk-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2004-10-22 at 12:23 +0100, Alan Cox wrote:
>> No it did not. It has never been a safe assumption.
> 
> OK, thanks.  Still no answer to my original question though.
> 
> JACK makes extensive use of microsecond-level timers.  These must be
> calibrated at startup, and recalibrated when the CPU speed changes.  How
> does JACK register with the kernel to be notified when the CPU speed
> changes?

The kernel does not always know when the CPU speed changes. This makes
notification somewhat harder.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
