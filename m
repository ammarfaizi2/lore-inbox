Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWBFWva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWBFWva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWBFWv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:51:29 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40680 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932413AbWBFWv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:51:29 -0500
Subject: Re: libATA  PATA status report, new patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060206200400.E69E8142E2@rhn.tartu-labor>
References: <20060206200400.E69E8142E2@rhn.tartu-labor>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Feb 2006 22:53:36 +0000
Message-Id: <1139266416.10437.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-06 at 22:04 +0200, Meelis Roos wrote:
> AC>         http://zeniv.linux.org.uk/~alan/IDE
> AC> 
> AC> for 2.6.16-rc2 patches.
> 
> Should I #define ATA_ENABLE_PATA by hand in include file to get PIIX4
> PATA to wotk with the ata_piix driver, or should it just work?

You should set that define. Actually I should do that by default in the
patch set. I will fix that.

