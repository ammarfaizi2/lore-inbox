Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130452AbQKTAbw>; Sun, 19 Nov 2000 19:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbQKTAbd>; Sun, 19 Nov 2000 19:31:33 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:36617
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130452AbQKTAb2>; Sun, 19 Nov 2000 19:31:28 -0500
Date: Sun, 19 Nov 2000 16:01:05 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Dan Aloni <karrde@callisto.yi.org>
cc: Taisuke Yamada <tai@imasy.or.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old
 BIOS
In-Reply-To: <Pine.LNX.4.21.0011200112300.991-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.10.10011191553360.21359-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Dan Aloni wrote:

> Well, I could patch it so it adds that one sector ;-) But that's not the
> right way. The true number of sectors is 90069840, since 90069839 doesn't
> divide by the number of *real* heads (6) and the number of recording zones
> (15). So it needs fixing.

15 == 16 if 0 == 1 in realm of counting numbers.

Also geometry is a lie to begin with, so what is one more lie on top of
another?

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
