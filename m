Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265696AbUFDJfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265696AbUFDJfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUFDJfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:35:36 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3200 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265692AbUFDJfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:35:22 -0400
Date: Fri, 4 Jun 2004 10:43:02 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406040943.i549h2aG000175@81-2-122-30.bradfords.org.uk>
To: Rick Jansen <rick@rockingstone.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20040604075448.GK18885@web1.rockingstone.nl>
References: <20040604075448.GK18885@web1.rockingstone.nl>
Subject: Re: DriveReady SeekComplete Error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Rick Jansen <rick@rockingstone.nl>:
> May 30 07:08:18 web3 kernel: hda: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> May 30 07:08:18 web3 kernel: hda: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=227270012, sector=227270007
> May 30 07:08:18 web3 kernel: end_request: I/O error, dev hda, sector
> 227270007
> 
> I could find some other people on the net with these problems, but none
> of them happened with brandnew drives. 
> 
> What can I do?

Please post more information.  First, what size is the disk?

The LBAsect number suggests an access around 108 Gb.  If the disk is smaller
than this, then it would appear that a request was made for a non-existant
sector.

Is the LBAsect number the same in each error?  What is the machine doing
when the errors occur?

John.
