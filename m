Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUFEErc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUFEErc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 00:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUFEErc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 00:47:32 -0400
Received: from fmr11.intel.com ([192.55.52.31]:7362 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S265972AbUFEEqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 00:46:54 -0400
Subject: Re: 2.6.7-rc2-mm1 (nforce2 lockup)
From: Len Brown <len.brown@intel.com>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <40C1455E.30501@blueyonder.co.uk>
References: <A6974D8E5F98D511BB910002A50A6647615FD33E@hdsmsx403.hd.intel.com>
	 <1086385540.2241.322.camel@dhcppc4>  <40C1455E.30501@blueyonder.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1086410810.2288.339.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jun 2004 00:46:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 00:00, Sid Boyce wrote:

> I just built and successfully booted 2.6.7-rc2-mm2 IOAPIC enabled and 
> without boot option acpi=off. I guess somewhere IOAPIC was inadvertently 
> disabled in .config.

Hmmm, so you should be able to make this new kernel boot-hang with
"noapic", yes?

How about if you go all the way and use "nolapic"?

thanks,
-Len


