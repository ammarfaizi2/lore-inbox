Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTLOOxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 09:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTLOOxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 09:53:35 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40907 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263692AbTLOOxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 09:53:34 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bob <recbo@nishanet.com>
Subject: Re: IRQ disabled (SATA) on NForce2 and my theory
Date: Mon, 15 Dec 2003 15:55:51 +0100
User-Agent: KMail/1.5.4
References: <frodoid.frodo.87wu8zzgly.fsf@usenet.frodoid.org> <3FDD4F7C.7090303@nishanet.com>
In-Reply-To: <3FDD4F7C.7090303@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312151555.51845.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 of December 2003 07:06, Bob wrote:
> sii chips have a long history of needing to
> hdparm off the unmask interrupt feature.
>
> I don't know about that chip but for
> sii680 there is a special option "-p9"
> for hdparm which is to say pio mode 9
> is a special instruction in addition to
> standard hdparm opt "-u0" turning off
> irq unmask.

There is no such thing as 'special option "-p9"' for sii680.

> /sbin/hdparm -d1 -c1 -p9 -X70 -u0 -k0 -i $a

-X70 is only valid if your device is UDMA133.

--bart

