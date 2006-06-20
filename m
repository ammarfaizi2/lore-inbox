Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWFTOvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWFTOvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWFTOvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:51:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9964 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751190AbWFTOvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:51:07 -0400
Subject: Re: Porting BSD console screensavers to Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tony Rowe <ay986@chebucto.ns.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060620144032.GA1919@chebucto.ns.ca>
References: <20060620144032.GA1919@chebucto.ns.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jun 2006 16:06:16 +0100
Message-Id: <1150815976.11062.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 11:40 -0300, ysgrifennodd Tony Rowe:
> Hello,
> 
> I have been wondering about this for a few years. Are there any 
> [non-locking] screensavers for the Linux console like 'warp_saver' which 
> is implemented in the BSD kernel I think?  Could the BSD syscons 
> screensavers be implemented in the Linux kernel?  The warp_saver.c is 
> included below.

Why do it in the kernel ? It would seem to be far more sensible to use a
callout via udev or similar so that savers could live in user space

