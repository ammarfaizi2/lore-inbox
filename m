Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUCQATV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUCQATV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:19:21 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:36826 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261865AbUCQATT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:19:19 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Status HPT374 (HighPoint 1540) Sata in 2.6
Date: Wed, 17 Mar 2004 01:27:33 +0100
User-Agent: KMail/1.5.3
References: <405786EC.5000803@matchmail.com> <40578F31.5090700@matchmail.com> <405796B0.9070906@matchmail.com>
In-Reply-To: <405796B0.9070906@matchmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403170127.33424.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think that it may work with drivers/ide/hpt366.c

AFAIK HPT374 is PATA only chipset and SATA support in HighPoint 1540
is achieved by using PATA-SATA bridges.

On Wednesday 17 of March 2004 01:07, Mike Fedyk wrote:
> Mike Fedyk wrote:
> > Hmm, it looks like it's "supported by at latest 2.4.21-pre5", but it
> > doesn't give details, or what SATA features are (or not) supported.
> > Though, what Jeff said probably overrides this...
>
> Oh, I remember now...
>
> Jeff said that back in 2003, and that's why I posted in the first place.
>
> Jeff, so if you have any details on the status of support for these
> cards in the 2.6 kernel (or with patches).
>
> Thanks,
>
> Mike

