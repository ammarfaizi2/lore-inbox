Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWAQTfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWAQTfc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWAQTfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:35:32 -0500
Received: from rtr.ca ([64.26.128.89]:63681 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751331AbWAQTfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:35:31 -0500
Message-ID: <43CD46B7.4000907@rtr.ca>
Date: Tue, 17 Jan 2006 14:34:15 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Sebastian Kuzminsky <seb@highlab.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sata_mv important note
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com>
In-Reply-To: <E1EytdC-0006DE-IS@highlab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Kuzminsky wrote:
>
> Can anyone recommend a 4xSATA (or more) controller on a PCI-X card that
> _is_ ready for production use?  eSATA ports are prefered but not required.
> Support for hotplug, power management (spindown) and SMART is prefered
> but not required.

The Pacific Digital QStor cards come in PCIX variants,
and support SATA2.  Hotplug et al is supported in the hardware,
but not in the Libata driver.  ATAPI is not supported at all.

Cheers
