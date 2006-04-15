Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWDOXll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWDOXll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWDOXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:41:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38826 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932187AbWDOXlk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:41:40 -0400
Subject: Re: SATA Conflict with PATA DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Bill Waddington <william.waddington@beezmo.com>
In-Reply-To: <444182B3.4050608@shaw.ca>
References: <61Y0s-AN-23@gated-at.bofh.it> <61UzA-43O-5@gated-at.bofh.it>
	 <61Y0s-AN-25@gated-at.bofh.it> <61Y0s-AN-21@gated-at.bofh.it>
	 <444182B3.4050608@shaw.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Apr 2006 00:51:02 +0100
Message-Id: <1145145062.32107.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-04-15 at 17:33 -0600, Robert Hancock wrote:
> The other way around is to make libata handle the PATA devices. I'm not 
> sure if the support for that on combined mode is in mainline or if you 
> need Alan's libata PATA patch for that?

There should be enough in 2.6.17-rc1 to just add the needed PCI
identifiers for recent chips to work SATA/PATA. There are some ugly bugs
left in the base code that the -ac patches fix in ata_piix but the core
stuff needed is in the base tree

