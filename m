Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTK3WmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 17:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTK3WmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 17:42:25 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:63762
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S261837AbTK3WmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 17:42:24 -0500
Date: Sun, 30 Nov 2003 23:42:19 +0100
From: Santiago Garcia Mantinan <lkml@manty.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA setting not available on 2.4.23 as a module
Message-ID: <20031130224219.GA691@man.beta.es>
References: <20031130195815.GA2409@man.beta.es> <200311302115.07898.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311302115.07898.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have piix.o module loaded or PIIX support compiled-in?

I had it compiled in, I didn't knew it could be compiled as a module, I have
tried compiling it as a module and DMA works ok, however the module along
with ide-core are not removable as piix says it is being used.

I have compiled the kernel again with ide modular and piix compiled in, just
in case I had not done it that way before and in fact I had done it that way
and I have verified that I had done it like that, DMA doesn't work as PIIX
driver is not used, I don't see any PIIX4 messages or any BM-DMA ones when
doing it this way, that is the problem.

Hope this clarifies things a little bit.

If you need any other info/test, don't hesitate to contact.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
