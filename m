Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965320AbWJ3Qxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbWJ3Qxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWJ3Qxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:53:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:874 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965320AbWJ3Qxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:53:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=grHee9q9UAuVhN46FrUqm5noaow3V4UxxGdFxzkM4vW9WHipibkZQl1E2dRTkzUlbs98DTJKe13N4cHBiLV0qztq2xEylOqYqQDU9eQyewkmcuyedy9IzehZznXkA4m28eNFO6Hu/ZuIzotAo6cm8jG/J2iK5NDMN+SM+R/nOKA=
Message-ID: <6b4e42d10610300853g16a7cee2w8f27523c81485859@mail.gmail.com>
Date: Mon, 30 Oct 2006 08:53:30 -0800
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Reuben Farrelly" <reuben-lkml@reub.net>
Subject: Re: 2.6.19-rc3-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4545D5AF.1090800@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061029160002.29bb2ea1.akpm@osdl.org> <4545D5AF.1090800@reub.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CPU1: Thermal monitoring enabled (TM1)
>                Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
> Brought up 2 CPUs
> testing NMI watchdog ... CPU#0: NMI appears to be stuck (58->63)!
> OK.
> time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
> Uhhuh. NMI received for unknown reason 3c.
> Do you have a strange power saving mode enabled?
> Dazed and confused, but trying to continue
> time.c: Detected 3000.114 MHz processor.
> migration_cost=21
Are you using AMD64 machine? Have you got powernow enabled in the bios?
I had seen the same problem. Disabling powernow / disabling HPET takes
this whining away :-)

Regards,
Om.
