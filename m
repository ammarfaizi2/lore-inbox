Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTEYJWt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 05:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTEYJWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 05:22:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6411 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261566AbTEYJWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 05:22:47 -0400
Date: Sun, 25 May 2003 10:35:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: john@grabjohn.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-scsi@vger.kernel.org
Subject: Re: [RFR] a new SCSI driver
Message-ID: <20030525103553.A26555@flint.arm.linux.org.uk>
Mail-Followup-To: john@grabjohn.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, linux-scsi@vger.kernel.org
References: <200305250944.h4P9i5Ct000456@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305250944.h4P9i5Ct000456@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Sun, May 25, 2003 at 10:44:05AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 10:44:05AM +0100, john@grabjohn.com wrote:
> Thinking ahead, by the 2.8 timescale, PATA could well be legacy hardware 
> which could be supported only by an 'old' IDE driver, much like we already
> have at the moment - I.E. we could remove the current 'old' IDE driver
> sometime during the 2.7 timescale, and support SATA only via the SCSI layer.

Rubbish.  PIO mode ATA will be around for some years to come - there
is just too much invested there (especially in the embedded world) for
it to vanish this quickly.  For example, think about compact flash cards,
many of which are still driven using PIO mode accesses in todays PDAs.

(and in some PDAs, there isn't the hardware facilities to even think
about trying any type of DMA transfer.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

