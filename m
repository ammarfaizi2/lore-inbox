Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWG0Myu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWG0Myu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWG0Myu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:54:50 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:43277 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750793AbWG0Myt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:54:49 -0400
Date: Thu, 27 Jul 2006 08:54:27 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] Create IP100A Driver
Message-ID: <20060727125421.GB22935@tuxdriver.com>
References: <1154030065.5967.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154030065.5967.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 03:54:25PM -0400, Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> This is the first version of IP100A Linux Driver.

One general comment is that your patch is whitespace-damaged,
undoubtedly mangled by your mailer.  I would suggest that you use
a text- or curses-based mailer (like mutt or even mail) for sending
patches, but I'm sure there are graphical mailers that can be trained
to not be "too smart".

> +static struct pci_device_id ipf_pci_tbl[] __devinitdata = {
> +       {0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},
> +       {0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1},
> +       {0x1186, 0x1002, 0x1186, 0x1012, 0, 0, 2},
> +       {0x1186, 0x1002, 0x1186, 0x1040, 0, 0, 3},
> +       {0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
> +       {0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
> +       {0x13F0, 0x0200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
> +       {0,}
> +};

This PCI ID table is identical to the one in the sundance driver.
What advantage does this driver offer over sundance?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
