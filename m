Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUFJWbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUFJWbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUFJWbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:31:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29587 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263166AbUFJWbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:31:50 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Lars <terraformers@gmx.net>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Fri, 11 Jun 2004 00:35:48 +0200
User-Agent: KMail/1.5.3
References: <ca9jj9$dr$1@sea.gmane.org> <200406102356.07920.bzolnier@elka.pw.edu.pl> <caamob$gb0$1@sea.gmane.org>
In-Reply-To: <caamob$gb0$1@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406110035.48711.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 of June 2004 00:19, Lars wrote:
> just learned that
> setpci -H1 -s 0:0.0 6C.L=0x9F01FF01
> enables C1 *and* the 80ns stability fix.
>
> looks like i have to stick with my ugly little workaround for a while

"ugly"?

We can probably change kernel fixup to always do & 0x9F01FF01
but adding "force C1HD" kernel options sounds insane.

>
> best,
> lars
>
> > Order should be reversed.
> >
> > It can be perfectly handled in user-space as you've just showed. :-)
> > There is no need to add complexity to the kernel.

