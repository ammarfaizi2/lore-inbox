Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269493AbUICJcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269493AbUICJcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269476AbUICJYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:24:42 -0400
Received: from imag.imag.fr ([129.88.30.1]:61347 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S269623AbUICJY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:24:26 -0400
Date: Fri, 3 Sep 2004 11:23:26 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI-based i8042 keyboard/aux controller enumeration
Message-ID: <20040903092326.GA5256@linux.ensimag.fr>
Reply-To: 1094149495.5645.6.camel@localhost.localdomain
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Matthieu Castet <mat@ensilinx1.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Fri, 03 Sep 2004 11:24:15 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Iau, 2004-09-02 at 18:52, Bjorn Helgaas wrote:
> > Add ACPI-based i8042 keyboard and aux controller enumeration.

> You should probably also add the same for the non-ACPI path with the
> BIOS feature word query stuff in this case ?
Or just use pnp layer that already support pnpbios and hope that it will support acpi soon.
