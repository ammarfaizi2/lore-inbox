Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264184AbUENFIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbUENFIe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUENFIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:08:34 -0400
Received: from fmr99.intel.com ([192.55.52.32]:52101 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S264226AbUENFIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:08:32 -0400
Subject: Re: Bug in IDE/ATAPI CDROM DRIVER
From: Len Brown <len.brown@intel.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Gusev <ronne@list.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FB52C@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FB52C@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084511298.12359.253.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 May 2004 01:08:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 14:33, Bartlomiej Zolnierkiewicz wrote:
> This is ACPI bug not IDE/ATAPI one.
> 
> boot with "acpi=noirq" as workaround and contact ACPI maintainer :-)
> 
> Cheers.
> 
> On Thursday 13 of May 2004 20:24, Andrew Gusev wrote:
> > Hello Jens Axboe,
> > I'm try to report bug.
> >
> > [1.] ide-cd: cmd 0x5a timed out, hdd: lost interrupt

Please let me know if this patch does not address the problem:

http://lkml.org/lkml/2004/5/11/175

Note that it is included in 2.6.6-mm2

thanks,
-Len


