Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbWEOSZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWEOSZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWEOSZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:25:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31421 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965116AbWEOSZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:25:39 -0400
Subject: Re: [RFT] major libata update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <4468C530.6080409@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org>
	 <20060515101831.0e38d131.akpm@osdl.org>  <4468C530.6080409@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 19:37:56 +0100
Message-Id: <1147718277.26686.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 14:15 -0400, Jeff Garzik wrote:
> which persists on Sil 311x on rare motherboards.  The rest are either 
> addressed with the improved error handling, or are ATAPI + VIA AFAICS.

ATAPI + VIA to that pattern is also showing up on pata_via cases as
well, but only on via so far. Its as if there is a case where the IRQ of
the first command is lost sometimes.

