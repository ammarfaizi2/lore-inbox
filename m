Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUDQLgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 07:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUDQLgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 07:36:15 -0400
Received: from zero.aec.at ([193.170.194.10]:23054 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262923AbUDQLgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 07:36:14 -0400
To: Andreas Hartmann <andihartmann@01019freenet.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
References: <1LQfz-2na-5@gated-at.bofh.it> <1LQfz-2na-7@gated-at.bofh.it>
	<1LQfz-2na-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 17 Apr 2004 13:36:11 +0200
In-Reply-To: <1LQfz-2na-3@gated-at.bofh.it> (Andreas Hartmann's message of
 "Sat, 17 Apr 2004 07:10:05 +0200")
Message-ID: <m3u0zi96qc.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@01019freenet.de> writes:

> Marcelo Tosatti wrote:
>> On Fri, Apr 16, 2004 at 10:51:02AM -0300, Marcelo Tosatti wrote:
>> And again, unfortunately not everyone is running v2.6 on their production
>> environment, yet.
>
> That's right! I certainly won't run it before 2.6.20 or even higher on
> desktops. For example, 2.6 vanilla is much to slow (about 9%), even on
> desktops - tested with compiling. It must be fixed.

This most likely comes from the 1ms timer tick vs 10ms previously.  I
doubt this will change in mainline, but you can change it yourself
with an easy tweak. Just change the HZ parameter back to 100

-Andi

