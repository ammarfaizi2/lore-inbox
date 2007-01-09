Return-Path: <linux-kernel-owner+w=401wt.eu-S932156AbXAIPe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbXAIPe2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbXAIPe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:34:28 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:43818 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbXAIPe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:34:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CVM9qB71ugFCgpO7BfSLRXI2VJrnZFAa4zEn7/sTsNTFwM+/tKFErBMfU6GQjkyJXl3av8cbjrnCKfMMGsYPRKXnvmLepXmYcU+3C/Djxo4Aq4bi/+E3BVbYe09GwP8ujbEo4dpytDpXoympR0FtTxBfG+ESDgKLb/q2GDeaWRY=
Message-ID: <8355959a0701090733l74d03792q16b3022d949c7ae1@mail.gmail.com>
Date: Tue, 9 Jan 2007 21:03:58 +0530
From: Akula2 <akula2.shark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Jumping into Kernel development: About -rc kernels...
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

This question might sound dumb for many, and to some annoying too ;-)

Am enterting into -rc Kernel (testing & analysis) & involvement with
the kernel (contributing to patches). I have this doubt. I did refer
to applying-patches in the kernel documentation, this is what I got:-

> These are the base stable releases released by Linus. The highest numbered
> release is the most recent.

> If regressions or other serious flaws are found, then a -stable fix patch
> will be released (see below) on top of this base. Once a new 2.6.x base
> kernel is released, a patch is made available that is a delta between the
> previous 2.6.x kernel and the new one.

> To apply a patch moving from 2.6.11 to 2.6.12, you'd do the following (note
> that such patches do *NOT* apply on top of 2.6.x.y kernels but on top of the
> base 2.6.x kernel -- if you need to move from 2.6.x.y to 2.6.x+1 you need to
> first revert the 2.6.x.y patch).

I did understand till here. Should I start compile/test/debug
one-after-one in this fashion:-

2.6.19 source + patch-2.6.20-rc1
2.6.19 source + patch-2.6.20-rc2
2.6.19 source + patch-2.6.20-rc3
2.6.19 source + patch-2.6.20-rc4

OR

Pick the latest release number?

Note:

Am working for different requirements in the Labs with Linux
(Telecom/Embedded). This activity starting as an independant activity
in my home/sometimes in Labs. So, I wanted to jump into kernel
development (mainly as compile/test/debug/patch). Hope I get enough
encouragement ;-)

~Akula2
