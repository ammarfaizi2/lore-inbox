Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTJ0Muo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTJ0Muo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:50:44 -0500
Received: from totor.bouissou.net ([82.67.27.165]:52875 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261687AbTJ0Mun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:50:43 -0500
Content-Type: text/plain;
  charset="iso-8859-2"
From: Michel Bouissou <michel@bouissou.net>
Organization: Completely disorganized
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Patch for Promise PDC20276
Date: Mon, 27 Oct 2003 13:50:41 +0100
User-Agent: KMail/1.4.3
Cc: abrutschy@xylon.de, linux-kernel@vger.kernel.org
References: <200310271009.13054@totor.bouissou.net> <200310271049.15348@totor.bouissou.net> <200310271102.36476.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310271102.36476.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200310271350.41631@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 27 Octobre 2003 11:02, Bartlomiej Zolnierkiewicz a écrit :
>
> > Uh. I may have misunderstood, but I understood that using this option
> > would activate the controller's hardware RAID feature, which I don't
> > want.
>
> Quite opposite, it makes Linux use controller even if it was marked by BIOS
> as disabled (for RAID purposes).

So the Configure.help help text associated with this option is definitely 
unclear (I would say: misleading) because it barely says (in kernel 2.4.22):

<<<<<
Special FastTrak Feature
CONFIG_PDC202XX_FORCE
  For FastTrak enable overriding BIOS.
>>>>>

And I understood this as meaning <<enable the "FastTrak" RAID feature 
regardless of what BIOS says>>

Hmmmm...

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
