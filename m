Return-Path: <linux-kernel-owner+w=401wt.eu-S932913AbWL0FOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913AbWL0FOf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 00:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932914AbWL0FOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 00:14:35 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:44630 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932913AbWL0FOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 00:14:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=XJLpV1R7nmc3hKlSImsB8FrvE/eVmY5xWeMSTS5mYrQRmCHIbAvMdaMPUT2GR9LIt/Jew9bk2emxgkB83GB3MAWpWmfX/o9YZFEWyzvjlb+RHDX6gTChGX+BZXGjfs/tMQPam82mU+kBa5ppY9AqWbjv2rXp17zSvT3mCgHP4ho=
Message-ID: <4592012C.5070601@gmail.com>
Date: Wed, 27 Dec 2006 14:14:20 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Jose Alberto Reguero <jareguero@telefonica.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: sata_mv and Marvell 88SE6121
References: <200612221334.08539.jareguero@telefonica.net>
In-Reply-To: <200612221334.08539.jareguero@telefonica.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Alberto Reguero wrote:
> Can this sata controler Marvell 88SE6121 work with this driver?
> Is anything I can try to make it work?
> Any hints are welcome.
> Thanks.

Combination of sata_mv and pata_marvell should do it.  Beware that
sata_mv is still experimental.

-- 
tejun
