Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTEZFu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTEZFu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:50:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41623 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264289AbTEZFuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:50:54 -0400
Message-ID: <3ED1AE49.1040706@pobox.com>
Date: Mon, 26 May 2003 02:03:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
References: <20030526045833.GA27204@gtf.org> <1053928747.602.41.camel@gaston>
In-Reply-To: <1053928747.602.41.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Btw, Jeff, while I agree about not boring about old PATA hardware,
> I'd still like to see support for MDMA modes in there. For once,
> there is no real difference in supporting both UDMA and MDMA, it's
> really just a matter of extending the range of the "mode" parameter,
> and I'd like to be able to use the driver on configs like pmacs which
> typically have a U/DMA capable channel for the internal HD and one
> MDMA only channel (ATAPI CD/DVD, ZIP) without having to play bad tricks
> to get both drivers up.


We'll see... I would really like to ignore MDMA.  For the reasons just 
outlined in replies to Linus, PATA support is quite useful in limited 
situations, but is not at all the focus of the driver.  When situations 
arise where special support for some PATA situation is needed, I will 
most likely just say "use drivers/ide"...

	Jeff



