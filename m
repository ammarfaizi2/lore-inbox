Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVGUCoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVGUCoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 22:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVGUCoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 22:44:30 -0400
Received: from gherkin.frus.com ([192.158.254.49]:36843 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S261586AbVGUCoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 22:44:24 -0400
Subject: Re: Obsolete files in 2.6 tree
In-Reply-To: <42DED9F3.4040300@gmail.com> "from Jiri Slaby at Jul 21, 2005 01:10:43
 am"
To: Jiri Slaby <jirislaby@gmail.com>
Date: Wed, 20 Jul 2005 21:44:21 -0500 (CDT)
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20050721024421.D4857DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Are these files obsolete and could be deleted from tree.
> Does anybody use them? Could anybody compile them?
> 
> (...)
> drivers/scsi/NCR5380.c
> drivers/scsi/NCR5380.h
> (...)

The above are used by (at least) the PAS16 SCSI driver.  The PAS16 is
a 16-bit ISA soundcard that, in its "studio" incarnation, has a slow-
speed (intended for the CD-ROM drives of the time) SCSI interface based
on the NCR 5380.  As I recall, the Linux driver operated in polled mode
only: no interrupt handling capability.  That deficiency was never
corrected while I was a user of that card, and I quit using the card
somewhere in the 2.2 kernel version timeframe.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
