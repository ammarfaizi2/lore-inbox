Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbUCZCHS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 21:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbUCZCHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 21:07:18 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:29969 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S263816AbUCZCHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 21:07:12 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Matthew Wilcox" <willy@debian.org>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Adrian Bunk" <bunk@fs.tum.de>,
       <239952@bugs.debian.org>, <debian-devel@lists.debian.org>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: RE: Binary-only firmware covered by the GPL?
Date: Thu, 25 Mar 2004 18:06:37 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEFILEAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2096
In-Reply-To: <81ptb0wh45.wl@omega.webmasters.gr.jp>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 25 Mar 2004 17:45:04 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
Reply-To: davids@webmaster.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> At Fri, 26 Mar 2004 00:33:39 +0000,

> Matthew Wilcox wrote:

> > I realise there's a grey area between "magic data you write to a device"
> > and "a program that is executed on a different processor".  For example,
> > palette data for a frame buffer.  But nobody's arguing for that grey
> > area here -- it's clearly a program without source code that Debian
> > can't distribute.

> Well, I also think this is grey area.

	On what basis? How is this file different from an executable?

	The gray area cases are where the code, as orginally written, is obscure.
Perhaps because it uses 'magic numbers' from data sheets rather than
symbolic constants. However, the GPL doesn't require you to add comments or
to write clear code. It simply prohibits deliberate obfuscation by one
particular means, namely having two forms of the code, one that you
distribute and one that you use to make modifications. (Other forms of
obfuscation are the gray areas.)

	But this case is squarely where the GPL says "no". In this case, there is
one form of the firmware for the purposes of making modifications to it and
there is another form that's distributed, ostensibly under the GPL.

> But think about: why can we distribute assembler only code in linux
> kernel?  It's near to binary form (objdump -d is your friend).

	We can distribute binaries if we want. The issue is that we cannot
distribute in any form and withhold the preferred form of the code for the
purpose of making modifications to it. How easy or hard it is to modify is
not the issue, one just can't take active steps to make it harder by
withholding the 'real source'.

> If they insist this source code is GPL, then I think this code is
> covered under GPL at least for this case.  If it's GPL, then we can
> derive the newer firmware code from this original ql2100_fw.c freely.

	I can't figure out what you're trying to say here. The file claims it is
GPL'd. If it is, then whoever receives it has a right to a copy of the
preferred form of that file for the purpose of making modifications to it.
Anyone who cannot distribute that preferred form cannot, according to the
GPL, distribute the other form.

	Bluntly, that file is the preferred form of the firmware for the purpose of
using or executing it. The GPL requires the preferred form for the purpose
of making modifications.

	IMO, the 'whole work' and 'linking' arguments are not important. The issue
is clear just from looking at this one file and what is required to
distribute it itself.

	DS

