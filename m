Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129114AbRBGOby>; Wed, 7 Feb 2001 09:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129070AbRBGObp>; Wed, 7 Feb 2001 09:31:45 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:31502 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129114AbRBGObf>; Wed, 7 Feb 2001 09:31:35 -0500
Message-ID: <3A815C42.629E68CB@Hell.WH8.TU-Dresden.De>
Date: Wed, 07 Feb 2001 15:31:30 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac4 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org, pdh@colonel-panic.com, andre@linux-ide.org
Subject: Re: VIA silent disk corruption - fixed for me
In-Reply-To: <14CC8D943BE7@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> After upgrading BIOS (it did not help) I decided to switch my secondary
> harddisk to master. And voila - hde running UDMA5, hdg running UDMA2
> (hdf/hdh does not exist), whole night stresstests, no corruption.

Excellent!

> So at least for me it means that Promise Linux driver does not support
> slave-only configuration. I did not checked whether master-slave pair
> works, but master alone for sure works for me.

I have a master-slave configuration. Both are IBM DTLA-307030 in UDMA-5
mode, the master using vfat32, the slave using ext2. Works like a charm.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
