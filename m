Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbUBPIl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbUBPIl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:41:26 -0500
Received: from ns.suse.de ([195.135.220.2]:47748 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265466AbUBPIlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:41:24 -0500
To: Christophe Saout <christophe@saout.de>
Cc: kangur@polcom.net, linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread
References: <1o4ML-V4-5@gated-at.bofh.it> <1pypu-2eR-25@gated-at.bofh.it>
	<1pySs-2Hu-13@gated-at.bofh.it> <1pzve-3a8-21@gated-at.bofh.it>
	<1pzEW-3hA-11@gated-at.bofh.it> <1pAhG-3RJ-29@gated-at.bofh.it>
	<1pArj-3ZE-31@gated-at.bofh.it> <1pG3C-kZ-9@gated-at.bofh.it>
	<1pGdl-qX-11@gated-at.bofh.it> <1pGn1-E8-23@gated-at.bofh.it>
	<1pHj1-1q2-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
In-Reply-To: <1pHj1-1q2-11@gated-at.bofh.it> (Christophe Saout's message of
 "Mon, 16 Feb 2004 04:10:07 +0100")
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
Date: Mon, 16 Feb 2004 04:58:48 +0100
Message-ID: <m38yj3llon.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> writes:

> Am Mo, den 16.02.2004 schrieb Grzegorz Kulewski um 03:07:
>
>> > Is there more documentation that this?  I'd imagine a lot of crypto-loop
>> > users wouldn't have a clue how to get started on dm-crypt, especially if
>> > they have not used device mapper before.
>> > 
>> > And how do they migrate existing encrypted filesytems?
>> 
>> And is the format considered "stable"?
>> (= if I will create fs on it, will I have problems with future kernels?)
>
> Yes. The cryptoloop compatible format will stay this way. The format
> (basically the cipher used and the iv generation mode) can be specified.

"Can be specified" = not stable, and likely means you cannot use old
file systems.

-Andi

