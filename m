Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313138AbSDMMpY>; Sat, 13 Apr 2002 08:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313334AbSDMMpX>; Sat, 13 Apr 2002 08:45:23 -0400
Received: from nydalah028.sn.umu.se ([130.239.118.227]:11691 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S313138AbSDMMpX>; Sat, 13 Apr 2002 08:45:23 -0400
Message-ID: <00b801c1e2e9$125e6cc0$0201a8c0@homer>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Urban Widmark" <urban@teststation.com>,
        "Shing Chuang" <ShingChuang@via.com.tw>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204131246420.5127-100000@cola.teststation.com>
Subject: Re: [PATCH 2.4.19-pre6] via-rhine.c to support new VIA's nic chip VT6105, V6105M (correct).
Date: Sat, 13 Apr 2002 14:45:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Urban Widmark" <urban@teststation.com>
> On Fri, 12 Apr 2002, Shing Chuang wrote:
>
> >       This patch applied to linux kernel 2.4.19-per6 to support VIA's
new
> > NIC chip.
> >       However, VIA don't have any nic chip with pci device id 0x6100 so
far,
> > so this patch also remove the device ID 0x6100.
>
> You are removing the entry for 0x3043, not 0x6100 ... Did you mean to also
> change "0x1106, 0x6100" to "0x1106, 0x3043" ?
>
> Older revision D-Link DFE530-TX NICs use a chip that identifies itself as
> 0x3043. This patch will break those.

Yuck... yes. It will totally break my two DFE530-TX'es... I wonder what
these guys are up to.

/Martin


