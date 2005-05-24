Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVEXJZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVEXJZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVEXJVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:21:02 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:43714 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261939AbVEXJSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:18:07 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091805.EF904F9D5@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:18:05 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 5BA05FB7A

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:49 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261251AbVEXEnF (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 00:43:05 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVEXEnF

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 00:43:05 -0400

Received: from gate.crashing.org ([63.228.1.57]:46286 "EHLO gate.crashing.org")

	by vger.kernel.org with ESMTP id S261251AbVEXEnD (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 00:43:03 -0400

Received: from gaston (localhost [127.0.0.1])

	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j4O4ZZZn000557;

	Mon, 23 May 2005 23:35:36 -0500

Subject: RE: ide-cd vs. DMA

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chad Kitching <CKitching@powerlandcomputers.com>
Cc: karim@opersys.com, Jens Axboe <axboe@suse.de>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <18DFD6B776308241A200853F3F83D50702128D31@pl6w2kex.lan.powerlandcomputers.com>

References: <18DFD6B776308241A200853F3F83D50702128D31@pl6w2kex.lan.powerlandcomputers.com>

Content-Type: text/plain

Date:	Tue, 24 May 2005 14:42:45 +1000

Message-Id: <1116909765.4992.21.camel@gaston>

Mime-Version: 1.0

X-Mailer: Evolution 2.2.2 

Content-Transfer-Encoding: 7bit

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



On Mon, 2005-05-23 at 23:26 -0500, Chad Kitching wrote:
> Are you using hdparm -k1 to keep your settings over a reset?  If you're 
> not, then this behaviour is really by-design.

And is broken. You can't expect users to play with hdparm and it's quite
common to have things like CSS or region errors on a DVD, taht shouldn't
turn your DMA off on the CD.

Damn, we are in 2005 folks !

Ben;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

