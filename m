Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbQKSO0l>; Sun, 19 Nov 2000 09:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbQKSO0c>; Sun, 19 Nov 2000 09:26:32 -0500
Received: from h-dialin-14.addcom.de ([213.61.83.14]:13061 "EHLO
	server1.localnet") by vger.kernel.org with ESMTP id <S129549AbQKSO0W> convert rfc822-to-8bit;
	Sun, 19 Nov 2000 09:26:22 -0500
To: andre@linux-ide.org
Cc: rene.rebe@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: VIA IDE UDMA Mode x -> CRC-ERRORs (2.4.0-testxx)
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.10.10011181725580.18257-100000@master.linux-ide.org>
In-Reply-To: <20001118233837L.rene@jackson>
	<Pine.LNX.4.10.10011181725580.18257-100000@master.linux-ide.org>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (GTK)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <20001119130207A.rene@jackson>
Date: Sun, 19 Nov 2000 13:02:07 +0100
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for the fast reply - but I can't follow. What is the _tuning
aspect_ and how is it modified?

Andre Hedrick <andre@linux-ide.org> wrote:

> 
> There is a problem that it does not downgrade the IO if all you have is
> iCRC errors.  The threshold is 10 events without other errors and it
> should skip you from ATA-66 to ATA-44.  If you did not enable the tuning
> aspect of the chipset then do so now.
> 
> Regards,
> 
> Andre Hedrick
> CTO Timpanogas Research Group
> EVP Linux Development, TRG
> Linux ATA Development
> 

k33p h4ck1n6 René

-- 
René Rebe (Registered Linux user: #127875)
http://www.rene.rebe.myokay.net/
-Germany-

Anyone sending unwanted advertising e-mail to this address will be charged
$25 for network traffic and computing time. By extracting my address from
this message or its header, you agree to these terms.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
