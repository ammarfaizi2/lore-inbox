Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVGVDoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVGVDoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVGVDoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:44:09 -0400
Received: from gherkin.frus.com ([192.158.254.49]:20929 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S261960AbVGVDoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:44:08 -0400
Subject: Re: Obsolete files in 2.6 tree
In-Reply-To: <42DF67BF.2070105@gmail.com> "from Jiri Slaby at Jul 21, 2005 11:15:43
 am"
To: Jiri Slaby <jirislaby@gmail.com>
Date: Thu, 21 Jul 2005 22:44:07 -0500 (CDT)
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20050722034407.C1C58DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Bob Tracy napsal(a):
> >Jiri Slaby wrote:
> >>Are these files obsolete and could be deleted from tree.
> >>Does anybody use them? Could anybody compile them?
> >>(...)
> >>drivers/scsi/NCR5380.c
> >>drivers/scsi/NCR5380.h
> >>(...)
> >
> >The above are used by (at least) the PAS16 SCSI driver.
>
> I think, that this driver uses g_NCR5380.c and g_NCR5380.h, doesn't it?

grep include pas16.c | grep NCR5380
produces...

#include "NCR5380.h"
#include "NCR5380.c"

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
