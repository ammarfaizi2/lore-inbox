Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262613AbRFFX6r>; Wed, 6 Jun 2001 19:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbRFFX6g>; Wed, 6 Jun 2001 19:58:36 -0400
Received: from zeus.kernel.org ([209.10.41.242]:16824 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262436AbRFFX60>;
	Wed, 6 Jun 2001 19:58:26 -0400
Date: Thu, 7 Jun 2001 01:52:45 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RTL8139, IRQ sharing, etc.
Message-ID: <20010607015245.B11765@emma1.emma.line.org>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010529215647.A3955@greenhydrant.com> <3B147F80.31EC7520@mandrakesoft.com> <20010531104437.C10057@emma1.emma.line.org> <3B17D471.D636E208@mandrakesoft.com> <20010601203127.B17137@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010601203127.B17137@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Fri, Jun 01, 2001 at 20:31:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jun 2001, Matthias Andree wrote:

> Not sure if it's related to IRQ sharing or another initialization issue.

Looks like IRQ sharing is still in the play.

Yesterday, I purchased a pair of used 3C905TXs, replaced the RTL 8139 by
the 3C905, and got complaints by the 3C905 about "eth0: Interrupt posted
but not delivered -- IRQ blocked by another device?" (Linux 2.2.19). The
other card on the same IRQ is a Brooktree 878.

I then swapped the Bt878 and the 3C900 (not 3C905!) and got no more
complaints, now, the Bt878 can keep its IRQ to itself, and the two 3Com
cards share the IRQ. Seems both NICs are fine. TV is also fine. Strange.

Might the BT 878 PCI AND the NVidia AGP card be the culprits?

Cheers,
Matthias
