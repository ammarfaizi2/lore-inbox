Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbTHZK2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbTHZK2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:28:24 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:62911 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S263682AbTHZK2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:28:21 -0400
Date: Tue, 26 Aug 2003 16:28:21 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: "Kevin P. Fleming" <kpfleming@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: ACPI breaks IDE/USB
In-Reply-To: <3F478636.3060002@cox.net>
Message-ID: <Pine.LNX.4.56.0308261626040.24343@hosting.rdsbv.ro>
References: <1061613751.897.12.camel@kahlua> <3F478636.3060002@cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When I enable ACPI on 2.6.0-test4 (also on 2.6.0-test3-*), the kernel no
> > longer recognises my IDE controller and drops down to PIO mode for
> > harddisk access. Additionally, USB devices don't get detected.
>
> I'm running -test4 here with ACPI and have no trouble with USB devices.
>
> > The system is an Athlon 2400+ on a Gibabyte GA-7VAXP mainboard. (KT400)
>
> My system is an Athlon 1000 on an MSI KT266-based board.

Same problem here. Without "pci=noacpi" the system doesn't detect any usb
decices, except hubs (internal ones)
Epox motherboard.
K7 650MHz

Till 2.6.0-test3-mm1 (or it was mm2?) it worked ok.
2.6.0-test4 has this problem.
The error is something about "nobody cared for interrupt #5".

I don't have more info now.

Thanks!

>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
