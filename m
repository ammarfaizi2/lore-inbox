Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbUCGMAp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 07:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUCGMAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 07:00:45 -0500
Received: from zero.aec.at ([193.170.194.10]:38405 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261824AbUCGMAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 07:00:44 -0500
To: Peter Zaitsev <peter@mysql.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high 
	end)
References: <1u7eQ-6Bz-1@gated-at.bofh.it> <1ue6M-45w-11@gated-at.bofh.it>
	<1uofN-4Rh-25@gated-at.bofh.it> <1vRz3-5p2-11@gated-at.bofh.it>
	<1vRSn-5Fc-11@gated-at.bofh.it> <1vS26-5On-21@gated-at.bofh.it>
	<1wkUr-3QW-11@gated-at.bofh.it> <1wolx-7ET-31@gated-at.bofh.it>
	<1woEM-7Yx-41@gated-at.bofh.it> <1wp8b-7x-3@gated-at.bofh.it>
	<1wp8l-7x-25@gated-at.bofh.it> <1x0qG-Dr-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 12 Mar 2004 22:15:23 +0100
In-Reply-To: <1x0qG-Dr-3@gated-at.bofh.it> (Peter Zaitsev's message of "Sun,
 07 Mar 2004 08:00:14 +0100")
Message-ID: <m3ish94vis.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev <peter@mysql.com> writes:
>
> Rather than changing design how time is computed I think we would better
> to go to better accuracy - nowadays 1 second is far too raw.

Just call gettimeofday(). In near all kernels time internally does that
anyways.

-Andi

