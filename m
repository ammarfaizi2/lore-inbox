Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268657AbUJDVsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268657AbUJDVsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUJDVrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:47:40 -0400
Received: from p508B61D6.dip.t-dialin.net ([80.139.97.214]:45602 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S268594AbUJDVli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:41:38 -0400
Date: Mon, 4 Oct 2004 23:41:07 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       greg@kroah.com
Subject: Re: [PATCH 2.6] pci-hplj.c: replace pci_find_device with pci_get_device
Message-ID: <20041004214107.GA2160@linux-mips.org>
References: <281940000.1096925207@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <281940000.1096925207@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 02:26:47PM -0700, Hanna Linder wrote:

> As pci_find_device is going away I have replaced this call with pci_get_device.

Looks good ...

> If  someone has access to an RM200 or RM300 and could test this I would appreciate it.

Except that piece of code isn't for an RM[23]00 but a HP Laserjet (yes,
that paper eating thing ;-) and hasn't seen any update or feedback from
the original submitters since the original submission, so the entire HPLJ
code is a candidate for removal ...

   Ralf
