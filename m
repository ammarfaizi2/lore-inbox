Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVAXX2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVAXX2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVAXXZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:25:31 -0500
Received: from palrel12.hp.com ([156.153.255.237]:7601 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261731AbVAXXX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:23:57 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16885.33669.126979.493091@napali.hpl.hp.com>
Date: Mon, 24 Jan 2005 15:23:49 -0800
To: Jon Smirl <jonsmirl@gmail.com>
Cc: davidm@hpl.hp.com, Keith Owens <kaos@ocs.com.au>, bgerst@didntduck.org,
       Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get
In-Reply-To: <9e47339105012415196a128899@mail.gmail.com>
References: <16885.30810.787188.591830@napali.hpl.hp.com>
	<30494.1106606658@ocs3.ocs.com.au>
	<16885.31766.730042.408639@napali.hpl.hp.com>
	<9e47339105012415196a128899@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 24 Jan 2005 18:19:05 -0500, Jon Smirl <jonsmirl@gmail.com> said:

  Jon> On Mon, 24 Jan 2005 14:52:06 -0800, David Mosberger
  Jon> <davidm@napali.hpl.hp.com> wrote:
  >> Well, the only place that I know of where I (have to) care about
  >> inter_module*() is because of the DRM/AGP dependency.  I can't
  >> imagine

  Jon> The DRM inter_module_XX dependency has been removed in
  Jon> 2.6.10. AGP still exports inter_module_XX so that things like
  Jon> Nvidia/ATI drivers will continue to work.

Not anymore:

  http://linux.bkbits.net:8080/linux-2.5/cset@41ef3420VDdf4OFNUTaC9jUaz8gR1A

	--david
