Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUENFU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUENFU0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbUENFU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:20:26 -0400
Received: from fmr02.intel.com ([192.55.52.25]:56221 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264226AbUENFUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:20:24 -0400
Subject: Re: oops ACPI in Linux-2.6.6-bk1
From: Len Brown <len.brown@intel.com>
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FB4FE@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FB4FE@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084511992.12354.256.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 May 2004 01:19:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 11:02, Pat LaVarre wrote:
> > ACPI: Subsystem revision 20040326 ...
> > [<c01eef72>] acpi_ev_save_method_info+0x44/0x75 ...
> > Unable to handle kernel NULL pointer dereferencec01e1194 ...
> > Kernel panic: Aiee, killing interrupt handler! ...
> > Unable <o ha1dleUn kernel NULL pointer dereferenceer
> dereferenceOoops: ...
> > Unable to handle kernel NULL pointer dereference at virtual address
> ...
> 
> Theory confirmed:
> 
> Deleting CONFIG_ACPI=y etc. via `make xconfig` fixes this.

what theory?

There were no ACPI changes between 2.6.6 and 2.6.6-bk1.
Does 2.6.6 work for you?

-Len


