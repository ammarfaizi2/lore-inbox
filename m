Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbQLKNc7>; Mon, 11 Dec 2000 08:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130553AbQLKNcu>; Mon, 11 Dec 2000 08:32:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:269 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130012AbQLKNcm>; Mon, 11 Dec 2000 08:32:42 -0500
Subject: Re: Linux 2.2.18 almost...
To: edmc@snowline.net (Eddy)
Date: Mon, 11 Dec 2000 13:03:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <000901c06354$7732e240$598d7ece@snowline.net> from "Eddy" at Dec 11, 2000 01:26:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145Sca-0007t3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> root=/dev/nfs ip=both ether=0,0,eth0     gives this result
> 
> Dec 10 22:50:52 Eddys dhcpd: DHCPDISCOVER from 00:50:ba:05:7b:fb via eth0
> Dec 10 22:50:52 Eddys dhcpd: DHCPOFFER on 192.168.50.2 to 00:50:ba:05:7b:fb
> via eth0

Those are DHCP. 'both' is the old keywords for rarp and bootp. It now behaves
as it should do for compatibility. Try 'on' or 'all'


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
