Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263788AbUEMGFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUEMGFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUEMGFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:05:07 -0400
Received: from zero.aec.at ([193.170.194.10]:22799 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263788AbUEMGFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:05:04 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel modules profile support (2.6.6)
References: <1VcTA-5Th-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 13 May 2004 08:04:36 +0200
In-Reply-To: <1VcTA-5Th-11@gated-at.bofh.it> (Randy Dunlap's message of
 "Thu, 13 May 2004 03:10:06 +0200")
Message-ID: <m3isf0q2vf.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> This patch (below) is an update of a 2.4.18 kernel patch that
> supports module profiling in the in-kernel profiler.

I don't think that's a good idea. Please keep the standard profiler
simple. And for anything complex we already have oprofile.

-Andi


