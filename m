Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUIXOKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUIXOKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268778AbUIXOKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:10:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:13543 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268771AbUIXOKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:10:06 -0400
Subject: Re: Libata - sata_sil - error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fabian Fenaut <fabian.fenaut@free.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
In-Reply-To: <415418DC.1090601@free.fr>
References: <415418DC.1090601@free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096031259.9730.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 14:07:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 13:53, Fabian Fenaut wrote:
> Since 7 sept, I had "EXT3-fs warning: mounting fs with errors, running
> e2fsck is recommended" when mounting this drive. So I tried to fsck, but
> it hangs and nothing happened.

2.6.7 doesn't have code to generate proper SATA error diagnostic
reports. 2.6.9rc2 will dump the ATA error state which will reveal a lot
more.

