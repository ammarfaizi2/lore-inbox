Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVFHHQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVFHHQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 03:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVFHHQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 03:16:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:50082 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262130AbVFHHQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 03:16:20 -0400
Date: Tue, 7 Jun 2005 23:52:07 -0700
From: Greg KH <greg@kroah.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1: cardmgr fails, 2.6.12-rc6 okay
Message-ID: <20050608065206.GA23114@kroah.com>
References: <b0uca1d7s5g5a4scln4a26q7ms5ismq67a@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0uca1d7s5g5a4scln4a26q7ms5ismq67a@4ax.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 02:57:38PM +1000, Grant Coady wrote:
> Hi there,
> 
> Toshiba 2210XCDS laptop, Celeron Coppermine, 440ZX, PIIX4E.
> 
> 2.6.12-rc6-mm1 cardmgr fails, from /var/log/debug:
> 
> Jun  8 13:05:41 tosh kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
> Jun  8 13:05:42 tosh kernel: PCI: Failed to allocate mem resource #1:800@10100000 for 0000:02:00.0
> Jun  8 13:05:42 tosh kernel: PCI: Failed to allocate mem resource #2:800@10100000 for 0000:02:00.0
> Jun  8 13:05:42 tosh kernel: PCI: Failed to allocate I/O resource #0:80@2000 for 0000:02:00.0

Ok, this is probably due to something in my tree.  I'll try to see if I
can duplicate this on my laptop tomorrow and let everyone know...

thanks,

greg k-h
