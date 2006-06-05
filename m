Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750803AbWFEVBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWFEVBe (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWFEVBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:01:34 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:20380 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1750803AbWFEVBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:01:33 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606052056.k55Ku7mR010143@wildsau.enemy.org>
Subject: Re: UDF: buggy? libdvdread vs. udf fs driver
In-Reply-To: <200606051753.k55HrpRl010049@wildsau.enemy.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Date: Mon, 5 Jun 2006 22:56:07 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


by the way, just to let you know ...

my attempt to create files via wrudf from the udftools
failed, too.

when operating on a diskimage, wrudf will exit with
"readPacket: read failed: bad address"

a closer look reveals that wrudf tries to read() into
a buffer-address of NIL.

yes, I'm using the latest udftools.

kind regards,
h.rosmanith
