Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWEHPyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWEHPyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWEHPyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:54:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29400 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932315AbWEHPyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:54:46 -0400
Subject: libata PATA patch update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 May 2006 17:06:40 +0100
Message-Id: <1147104400.3172.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted a new patch versus 2.6.17-rc3 up at the usual location.

http://zeniv.linux.org.uk/~alan/IDE

This has a lot less in it that touches the core libata code as the
majority of the changes for the core are now merged. I'm still working
down various bug reports and there are bigger changes to do with simplex
that are known but not yet resolved.

There are a couple of things still not yet dealt with in the core,
notably some of the speed management and serialization code but most of
it is there.

Driver support is now more extensive than the old drivers/ide code
although the degree of testing is much lower and there will be plenty of
small bugs left to knock out of the tuning code.

Bug reports/patches/comments welcome

Alan
