Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTL1RGE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTL1RGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:06:04 -0500
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:14464 "HELO
	mail.nicke.nu") by vger.kernel.org with SMTP id S261681AbTL1RGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:06:02 -0500
From: "Nicklas Bondesson" <nicke@nicke.nu>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Sun, 28 Dec 2003 18:06:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcPNZBIQ47lw1Dq7StCkj3oniOs81gAAHt+g
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.58L.0312281456090.15034@logos.cnet>
Message-Id: <S261681AbTL1RGC/20031228170602Z+16985@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, if I remember it correctly I have tried that too. Should it make any
difference? It seems like the problem is related to disk geometry failure
(the kernel is not seeing the correct geometry values for the drives) since
the patch I got worked fine.

/Nicke

-----Original Message-----
From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com] 
Sent: den 28 december 2003 17:57
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org; Bartlomiej Zolnierkiewicz
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)



On Sun, 28 Dec 2003, Nicklas Bondesson wrote:

> I really hope so :) I think you should wrap it up and send it to the 
> list marked as [PATCH].
>
> Many thanks for the help again!

Nicklas,

Have you tried to compile the kernel with CONFIG_PDC202XX_FORCE unset ?

