Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUHJPrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUHJPrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUHJPrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:47:07 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:49578 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267469AbUHJPp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:45:27 -0400
Date: Tue, 10 Aug 2004 17:44:38 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101544.i7AFic0s014401@burner.fokus.fraunhofer.de>
To: alan@lxorguk.ukuu.org.uk, axboe@suse.de, diablod3@gmail.com,
       dwmw2@infradead.org, eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de,
       skraw@ithnet.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jens Axboe <axboe@suse.de>

>Don't be naive. How do you discuss changes with him? The one patch I did
>create against the SUSE cdrecord for the one shipped with SL9.1 adds a
>note to use ATA over ATAPI since that is preferred, and it kills the
>silly open-by-devname warnings that are extremely confusing to users. I
>did send that back to Joerg, to no avail.

You never send such mail.... but you told me that that you liked me to
_remove_ warnings. 
Note that I also output warnings on Solaris if users use suboptimal interfaces.



>> While they (and any other distro's people and anybody else) may
>> actually hack the code to no end, I consider it being good habit to

>By far the largest modification is dvd support, which we of course need
>to ship. The rest is really minor stuff.

This "dvd support" has beed proved to be defective and it has also been proved
that it breaks CD support.

You don't like to see cdrecord to become worse do you?


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
