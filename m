Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUCZWLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUCZWLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:11:15 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:4357 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261351AbUCZWLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:11:12 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Binary-only firmware covered by the GPL?
Date: Fri, 26 Mar 2004 14:10:48 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEKGLEAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2096
In-Reply-To: <E1B6t8T-0000KZ-00@chiark.greenend.org.uk>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 26 Mar 2004 13:49:13 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Matt Reuther wrote:

> >I think the real question is this: if this binary blob is not
> >GPL, then how
> >can it be in the kernel? It should be pulled out and put in a
> >separate file,
> >which can be loaded with the firmware mechanism.

> Correct.

> >If it is firmware, then would it be legal to reverse engineer
> >the assembler,
> >assuming one can find the instruction set for the chip?

> That depends on your local jurisdiction.

	IANAL, but I believe you have the absolute right to reverse engineer and
modify it. All of that engineering and modification would be to/from a file
that was placed under the GPL, and the GPL contains no restrictions against
reverse engineering or modification. It specifically prohibits the
imposition of any addional restrictions upon those who receive the file as
far as how they can use, modify, and distribute it.

	There might be a question if the reverse engineering exceeds the scope of
the file itself. For example, if you reverse engineer the hardware that the
firmware runs on or if the firmware runs on a custom processor and you have
to reverse engineer the processor itself. But I certainly think you can
reverse engineer the contents of the firmware file (disassemble it) and make
modified versions of that firmware with absolute impunity.

	DS

