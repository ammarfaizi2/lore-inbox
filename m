Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbULJPHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbULJPHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbULJPHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:07:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:56316 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261293AbULJPHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:07:13 -0500
Subject: Sil3112 and Seagate ST3160023AS
From: Julien Langer <jlanger@zigweb.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 10 Dec 2004 16:07:11 +0100
Message-Id: <1102691231.3921.13.camel@moeff>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:b0db08a687644468549cd788b9c03e48
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know, Sil SATA controllers and Seagate disks are a bad combination.
However my Seagate drive worked flawlessly for about half a year and
hdparm -t tells my, it's working with approx. 50 mb/s.

I just switched from 2.6.7 to 2.6.10RC3 yesterday and noticed that my
drive now only works with 15 mb/s. Also I get a new message "applying
pessimistic Seagate errata fix" when booting, which wasn't there with
2.6.7.

Is there a way to disable this fix, which slows down my drive, since it
worked fine for a long time without this fix on older kernel versions?
I'm using the deprecated ide driver for the sil controller, not libata.

Thanks in advance,
Julien Langer

PS: Please CC me, I'm not on the list

