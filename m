Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTLVBXR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTLVBVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:21:35 -0500
Received: from zero.aec.at ([193.170.194.10]:32523 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264286AbTLVBV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:21:26 -0500
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c patches, take two
From: Andi Kleen <ak@muc.de>
Date: Mon, 22 Dec 2003 02:21:11 +0100
In-Reply-To: <15kfk-vj-1@gated-at.bofh.it> (Christophe Saout's message of
 "Sun, 21 Dec 2003 23:30:07 +0100")
Message-ID: <m31xqx7im0.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <MllE.6qa.7@gated-at.bofh.it> <MpyW.3Ub.9@gated-at.bofh.it>
	<MsGq.8cN.1@gated-at.bofh.it> <MvO6.47g.7@gated-at.bofh.it>
	<MEf3.8oB.13@gated-at.bofh.it> <MROA.319.5@gated-at.bofh.it>
	<NxkP.4kY.17@gated-at.bofh.it> <15hUp-58e-21@gated-at.bofh.it>
	<15iGH-6hd-17@gated-at.bofh.it> <15kfk-vj-1@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> writes:

> Am So, den 21.12.2003 schrieb Mika Penttilä um 21:49:
>
>> Yet another Big Loop Patch... :)
>> 
>> It's not obvious which parts are bug fixes, and which performance 
>> improvements. What exactly breaks loops on journalling filesystems, and 
>> how do you solve it?
>
> What about dropping block device backed support for the loop driver
> altogether? We now have a nice device mapper in the 2.6 kernel. I don't

Device Mapper doesn't support cryptographic transformations.

-Andi
