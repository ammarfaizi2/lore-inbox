Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTELNEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTELNEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:04:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13236 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262117AbTELNEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:04:24 -0400
Date: Mon, 12 May 2003 15:16:17 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Oliver Neukum <oliver@neukum.org>, Oleg Drokin <green@namesys.com>,
       <lkhelp@rekl.yi.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69, IDE TCQ can't be enabled
In-Reply-To: <200305121455.58022.oliver@neukum.org>
Message-ID: <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 May 2003, Oliver Neukum wrote:

> > Just a note that we have found TCQ unusable on our IBM drives and we had
> > some reports about TCQ unusable on some WD drives.
> >
> > Unusable means severe FS corruptions starting from mount.
> > So if your FSs will suddenly start to break, start looking for cause with
> > disabling TCQ, please.
>
> I can confirm that. This drive Model=IBM-DTLA-307045, FwRev=TX6OA60A,
> SerialNo=YMCYMT3Y229 has eaten my filesystem with TCQ on 2.5.69
>
> 	Regards
> 		Oliver

TCQ is marked EXPERIMENTAL and is known to be broken.
Probably it should be marked DANGEROUS or removed?

Alan, what do you think?

--
Bartlomiej

