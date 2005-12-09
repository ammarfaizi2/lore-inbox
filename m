Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVLIMZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVLIMZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 07:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVLIMZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 07:25:09 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:52958 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751027AbVLIMZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 07:25:07 -0500
Date: Fri, 9 Dec 2005 12:24:57 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051209122457.GB26070@srcf.ucam.org>
References: <20051208141811.GB21715@srcf.ucam.org> <1134052433.17102.17.camel@localhost.localdomain> <20051208145257.GB21946@srcf.ucam.org> <20051208171901.GA22451@srcf.ucam.org> <20051209114246.GB16945@infradead.org> <20051209114944.GA1068@havoc.gtf.org> <20051209115235.GB25771@srcf.ucam.org> <43997171.9060105@pobox.com> <20051209121124.GA25974@srcf.ucam.org> <439975AB.5000902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439975AB.5000902@pobox.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 07:16:43AM -0500, Jeff Garzik wrote:

> libata will immediately notice the ejection without ACPI's help.

http://linux.yyz.us/sata/sata-status.html claims that ICH6 doesn't 
support hotswap. The Intel docs seem to say the same thing. Pulling the 
drive out generates an ACPI interrupt but not a PCI one. I'm really 
happy to be wrong here, it's just that everything I've been able to find 
so far suggests that ACPI is the only way to get a notification that the 
drive has gone missing :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
