Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWHNRRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWHNRRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWHNRRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:17:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:56193 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932506AbWHNRRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:17:05 -0400
Subject: Re: aic7xxx broken in 2.6.18-rc3-mm2
From: Dave Hansen <haveblue@us.ibm.com>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Greg KH <greg@kroah.com>, Marcus Better <marcus@better.se>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>, ak@suse.de
In-Reply-To: <200608141858.37465.daniel.ritz-ml@swissonline.ch>
References: <1155334308.7574.50.camel@localhost.localdomain>
	 <200608130002.40223.daniel.ritz-ml@swissonline.ch>
	 <1155571551.7574.143.camel@localhost.localdomain>
	 <200608141858.37465.daniel.ritz-ml@swissonline.ch>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 10:16:44 -0700
Message-Id: <1155575804.7574.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 18:58 +0200, Daniel Ritz wrote:
> hmm..should be 2.6.16 behavior with this...
> what kind of box is this?

I know my earlier description was vague.  Please let me know if there
are any specifics you need.

> could you give me dmesg output of plain 2.6.18-rc4

http://sr71.net/~dave/linux/daniel.ritz/dmesg-elm3b82-2.6.18-rc4.txt

> and a 2.6.18-rc4 with the patch (not -mm if possible)?

http://sr71.net/~dave/linux/daniel.ritz/dmesg-elm3b82-2.6.18-rc4-with-gregkh-pci-pci-use-pci_bios-as-last-fallback.txt

> oh...and a lspci -vvv please

http://sr71.net/~dave/linux/daniel.ritz/lspci-vvv-elm3b82.txt

(A reversed copy of) the patch I applied to 2.6.18-rc4 is in that
directory, too:

http://sr71.net/~dave/linux/daniel.ritz/gregkh-pci-pci-use-pci_bios-as-last-fallback.patch

-- Dave

