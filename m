Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289092AbSAJAMJ>; Wed, 9 Jan 2002 19:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289094AbSAJAL7>; Wed, 9 Jan 2002 19:11:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47364 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289092AbSAJALt>; Wed, 9 Jan 2002 19:11:49 -0500
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: pbadari@us.ibm.com (Badari Pulavarty)
Date: Thu, 10 Jan 2002 00:23:18 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pbadari@us.ibm.com (Badari Pulavarty),
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <200201092320.g09NK1224012@eng2.beaverton.ibm.com> from "Badari Pulavarty" at Jan 09, 2002 03:20:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OT03-0002mK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tested with 2 large competing databases, both of them seem to benifit 
> significantly from this patch. I tested with 4 different Fiber & SCSI
> adaptors, they all seem to work fine. (only on i386).

Great.

> But unfortunately, if the hardware have special alignment restrictions
> (as you mentioned), this patch does not work. I don't know if it makes
> sense to make this configurable and expect customer/user to enable this
> feature if they know about their hardware/driver alignment restrictions.

The only one I know about is the 3ware, but I don't know how many I don't
know about (so to speak). For the kind of win you report, it looks well
worth exploring the compatibility issues and fixing them.

