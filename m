Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbTJCTeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 15:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbTJCTeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 15:34:18 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17826 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262676AbTJCTeQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 15:34:16 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH][IDE] small cleanup for AMD/nVidia IDE driver
Date: Fri, 3 Oct 2003 21:36:46 +0200
User-Agent: KMail/1.5.4
References: <200310032034.01122.bzolnier@elka.pw.edu.pl> <20031003190445.GB748@ucw.cz>
In-Reply-To: <20031003190445.GB748@ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310032136.46777.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 of October 2003 21:04, you wrote:
> On Fri, Oct 03, 2003 at 08:34:01PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Almost identical to VIA's patch.
>
> Both look fine. I'll be sending you an update for AMD-8111 @UDMA133 and
> for nForce3 soon, too.

Cool, I'll push these two patches to Linus.

I've seen 2.4.x patches from Allen Martin@nVidia on lkml.
In UDMA133 patch he mentioned that UDMA should be programmed by mode,
not UDMA cycle timing on nVidia chipsets (probably the same applies to AMD).
Can you comment on this?

Also please don't add new SATA chipsets to drivers/ide.
They should be handled by jgarzik's libata.

Thanks,
--bartlomiej

