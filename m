Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266789AbUHCSbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266789AbUHCSbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266806AbUHCSbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:31:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:22972 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266789AbUHCSbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:31:36 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408031528.i73FSPrB021051@falcon10.austin.ibm.com>
References: <200408031528.i73FSPrB021051@falcon10.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091554122.3946.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 18:28:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-03 at 16:28, Doug Maxey wrote:
>   Where would the case of firmware download fit?  For x86 ATA/ATAPI
>   devices, the vendor usually supplies a dos disk to accomplish this.

We already have CAP_SYS_RAWIO methods for such things so that is ok.
As to the claim that allowed commands vary by device I disagree. At the
"user safe" level the list is somewhat smaller and consistent

