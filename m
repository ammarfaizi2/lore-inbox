Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTJSUfW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 16:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTJSUfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 16:35:22 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35589
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262168AbTJSUfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 16:35:14 -0400
Date: Sun, 19 Oct 2003 13:30:22 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Svetoslav Slavtchev <svetljo@gmx.de>
cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
Subject: Re: HighPoint 374
In-Reply-To: <24673.1066593435@www23.gmx.net>
Message-ID: <Pine.LNX.4.10.10310191329150.15306-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You do not enable TCQ on highpoint without using the hosted polling timer.
Oh and I have not added it, and so hit Bartlomiej up for the additions.

Andre Hedrick
LAD Storage Consulting Group

On Sun, 19 Oct 2003, Svetoslav Slavtchev wrote:

> i have the same problems with epox 8k9a3+,
> and may be even strange ones
> (like fs coruption when soft raid & / or lvm is used)
> 
> and i never had the problems with 8k5a3+,
> the drives were actually taken from the 8k5a3+
> when it died (me silly tried to update to XP2700)
> 
> really strange, isn't it
> 
> both boards should be the same, except
> 8k5a3+ uses kt333
> 8k9a3+ uses kt400
> 
> only mainboard change -> hell of a lot unresolved problems
> 
> 
> svetljo
> kernels used 2.4.21-2.4.23-pre3 2.6.0-test3-test7bk8
> 
> and a nice log when i try to enable TCQ
> 
> all Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>] 
> [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1022
> Call Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>] 
> [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1022
> Call Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>] 
> [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1022
> Call Trace: [<c0235ee3>]  [<c022e834>]  [<c025b0ef>]  [<c026e0ed>] 
> [<c025c7e2>]  [<c026e080>]  [<c010df03>]  [<c010e233>]  [<c010c7d8>]
> 
> 
> -- 
> NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
> Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService
> 
> Jetzt kostenlos anmelden unter http://www.gmx.net
> 
> +++ GMX - die erste Adresse für Mail, Message, More! +++
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

