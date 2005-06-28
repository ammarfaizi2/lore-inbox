Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVF1HB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVF1HB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVF1Ggy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:36:54 -0400
Received: from [85.8.12.41] ([85.8.12.41]:10681 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261645AbVF1G3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:29:11 -0400
Message-ID: <42C0EE1A.9050809@drzeus.cx>
Date: Tue, 28 Jun 2005 08:28:42 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>
In-Reply-To: <42BB3428.6030708@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... it seems that TPM has something to do with the bug. Not sure why
though, can't see anything TPM related in dmesg. If I disable the TPM
parts in kconfig then the network works just fine.

I'm going to do a test of 2.6.12-rc1 through rc6 today to see where the
problem appears.

Rgds
Pierre
