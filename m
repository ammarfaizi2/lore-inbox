Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVF1BBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVF1BBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 21:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVF1BBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 21:01:52 -0400
Received: from smtpout1.uol.com.br ([200.221.4.192]:15071 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S262358AbVF1BBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 21:01:48 -0400
Date: Mon, 27 Jun 2005 22:00:52 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels (was: Re: 2.6.12-mm2)
Message-ID: <20050628010052.GA3947@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050627164540.7ded07fc.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 27 2005, Andrew Morton wrote:
> Could you please generate the dmesg output from 2.6.12 and 2.6.12-mm2 and,
> if there are any relevant-looking differences, send them?

Ok, I put them both on <http://www.ime.usp.br/~rbrito/bug/>.

> Also, try:
> 
> wget (...)
> patch -R -p1 < gregkh-pci-pci-collect-host-bridge-resources-02.patch

Ok. I am compiling the kernel right now and will post the results as soon
as I am finished.

> Thanks.

Thank you very much for your feedback, Rogério.

P.S.: I just noticed right now that the patch listed above changes only
arch/i386/pci/acpi.c, but I am not using ACPI. Well, I will proceed anyway.
-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
