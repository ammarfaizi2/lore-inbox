Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbULETHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbULETHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 14:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbULETHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 14:07:13 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:48616 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261352AbULETHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 14:07:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lu4ROe27pYCyAsKvgPedsu0zyjfHgrzXfIlnIB8lWXzstMMx2Fmq3kZtnAn+Mtgh1gZtGx0sQt+GIEmbdc69ny5RWh5/UuraeTQc2s891yPk/fIR/lbuhQ9t+CroFsrVHrve2b16KdZWkeVlnuZkqcD3vq0oUK++3VEa50yEVFI=
Message-ID: <58cb370e041205110616263c35@mail.gmail.com>
Date: Sun, 5 Dec 2004 20:06:56 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: lkml@think-future.de, Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Re: Promise module (old) broken
In-Reply-To: <20041205195358.DC2B5440E2@service.i-think-future.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041205195358.DC2B5440E2@service.i-think-future.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004 18:54:00 +0100, lkml@think-future.de
<lkml@think-future.de> wrote:
>   Hi,
> 
>   up to the actual kernel rc 2.6.10rc3 has broken pdc 20265 support. As
> some kernel releases ago, one had to specify i/o ports on kernel
> cmdline. 2.4.28 kernel works w/o cmdline parameter.
> 
> Is this behaviour intended? Will it be fixed in 2.6.10 release?

Haven't you forgot to compile in pdc202xx_old driver?

> W/o parameter kernel (2.6) does not recognise the pdc ide controller
> drives.
> dmesg output states: "ideX: Wait for ready failed before probe !"
> 
> As of kernel rc 2.6.10rc1 the kernel even reported ide drive short
> read and seek errors on drives even not connected to the pdc
> controller but connected to the onboard controller (->/dev/hda1). In
> fact /dev/hda1 has no errors (so far).
>
> Any comments?

Read REPORTING-BUGS from the kernel source package
and give us at least dmesgs and configs.
