Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWBHDCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWBHDCG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWBHDCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:02:05 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:45531 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030473AbWBHDCE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:02:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iVhlqqOag+/sMBgFV0Zv/b43cxFceu4DGTAvbxlkbs+ofqSumNlqnFOcas1BPBSM8x1VlLwnBs/uWvxmEqwdh79MJ5AwXWogqYR3jj932PIjck4qKHW0g7lPkaFyhFUdXRRMQVo4sSHRdl9qGFhbqme5bsR+cde4UKycitk+uKc=
Message-ID: <e282236e0602071902u41a5c005rdc9be5be0939b4ee@mail.gmail.com>
Date: Wed, 8 Feb 2006 11:02:00 +0800
From: Yoseph Basri <yoseph.basri@gmail.com>
To: "Boris B. Zhmurov" <bb@kernelpanic.ru>
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43E87749.8030206@kernelpanic.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
	 <43E87749.8030206@kernelpanic.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

I think so, here is from the dmeg info:

Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:06:08.0[A] -> GSI 29 (level, low) -> IRQ 16
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:06:08.1[B] -> GSI 30 (level, low) -> IRQ 17
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation

any info regarding this warning?

YB

On 2/7/06, Boris B. Zhmurov <bb@kernelpanic.ru> wrote:
> Hello, Yoseph Basri.
>
> On 07.02.2006 12:46 you said the following:
>
> > I am getting the warning log:
> >
> > kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
> > net/core/stream.c (279)
> > kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
> > net/ipv4/af_inet.c (148)
>
>
> Do you have Intel Pro 1000 network card? Same here...
>
>
> --
> Boris B. Zhmurov
> mailto: bb@kernelpanic.ru
> "wget http://kernelpanic.ru/bb_public_key.pgp -O - | gpg --import"
>
>
