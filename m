Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130866AbRBIWnO>; Fri, 9 Feb 2001 17:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRBIWnE>; Fri, 9 Feb 2001 17:43:04 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:36367 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130866AbRBIWmo>; Fri, 9 Feb 2001 17:42:44 -0500
Message-ID: <3A847252.54AD7579@Hell.WH8.TU-Dresden.De>
Date: Fri, 09 Feb 2001 23:42:26 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac9 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1ac9
In-Reply-To: <E14RLSq-00083m-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:
> 
>         ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 2.4.1-ac9
> o       Merge with Linus 2.4.2pre2

I've noticed that -ac9 comes with the "Disable PCI-Master-Read-Caching
on VIA" patch that Peter Horton posted a while back. I don't know
whether it was applied in Linus' or your tree first, but is it
actually verified to fix anything?

AFAIR Peter Horton later posted that it didn't fix a thing for him and
Petr Vandrovec tracked down his corruption issue to a Promise driver
problem. I see no corruption with Master-Read-Caching enabled here and
unless someone can verify that it really is the culprit, the patch
is probably completely redundant.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
