Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUBOTN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 14:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUBOTN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 14:13:27 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29315 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265148AbUBOTN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 14:13:26 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Kyle" <kyle@southa.com>
Subject: Re: ICH5 with 2.6.1 very slow
Date: Sun, 15 Feb 2004 20:19:34 +0100
User-Agent: KMail/1.5.3
Cc: <linux-kernel@vger.kernel.org>
References: <021801c3f3f4$50f66280$353ffea9@kyle>
In-Reply-To: <021801c3f3f4$50f66280$353ffea9@kyle>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402152019.34858.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 of February 2004 19:48, Kyle wrote:
> today since one of my mirrored harddisk (/dev/hda) failed, I removed it
> from md-raid1 and now /dev/hdc becomes /dev/hda
>
> hdparm -t /dev/hda gets me ~37MB/s now (before: /dev/hda - 30MB/s,
> /dev/hdc - 37MB/s)
>
> maybe there's problem with /dev/hda so it's relatively slower!
>
> However, the result still much slower than kernel 2.4.20 (55MB/s)

Please fill bugzilla entry (htp://bugzilla.kernel.org)
and attach 'dmesg' and 'lspci -vvv -xxx' outputs for 2.4.20 and 2.6.x.

It would be also helpful to narrow down the issue to kernel version when
this slowdown started (2.4.20 -> 2.6.x means too much changes to anybody
sane to even start thinking about going through all of them).

--bart

