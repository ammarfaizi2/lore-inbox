Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUCHUrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUCHUrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:47:00 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:38597 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261186AbUCHUq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:46:57 -0500
Date: Mon, 8 Mar 2004 15:46:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Bjoern Schmidt <lucky21@uni-paderborn.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsb of older cpu
In-Reply-To: <404CD4E7.5050105@uni-paderborn.de>
Message-ID: <Pine.LNX.4.58.0403081545200.29087@montezuma.fsmlabs.com>
References: <404C4D32.1080609@uni-paderborn.de>
 <200403081714.04182.bernd.schubert@pci.uni-heidelberg.de>
 <404CD4E7.5050105@uni-paderborn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2004, Bjoern Schmidt wrote:

> Hello and thank you for your answer. I determined that this cpu has a fsb of
> 66MHz. The reason for my question was that i want to underclock the cpu.
> I think it would be better to change the multiplier instead of changing the fsb.
> Therefore i read the msr register 0x02ah, tilted bit 27 and wrote it back, but
> the cpu clock is still the same. Why does that not work? Is it possible to
> change the multiplier at runtime at all?

No, the multiplier is locked, you'll have more luck fiddling with the
front side bus.

