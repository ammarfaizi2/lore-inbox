Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264295AbUFGFy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbUFGFy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 01:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264306AbUFGFy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 01:54:27 -0400
Received: from miranda.se.axis.com ([193.13.178.2]:20935 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264295AbUFGFy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 01:54:26 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Sam Ravnborg'" <sam@ravnborg.org>,
       "'Mikael Starvik'" <mikael.starvik@axis.com>
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: RE: [PATCH] CRIS architecture update
Date: Mon, 7 Jun 2004 07:53:30 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F49D@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668D47C24@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The general rule is to locate drivers under drivers/, even the arch 
>specific ones. This allows for easier grepping after users of a
>given API etc.

Ok, if that is a general rule I can move them (but the patch will
be large...). Generally we don't expect people to take attention 
about CRIS when making changes but it is of course nice when it 
happens.

>Smaller logical splitted patches, being sent out after each kernel release.
>This allows LKML readers to do peer review of changes to the IDE driver,
>without having to step over a lot of unrelated code.

Sure. More work for me but I'll also get more valuable feedback
and that is important.

/Mikael

