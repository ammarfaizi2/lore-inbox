Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbTDVWzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTDVWzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:55:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6625
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263892AbTDVWzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:55:49 -0400
Subject: Re: nforce2 IDE DMA stopped working (2.4.21-rc1)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Walter Hofmann <nforce2-030422223536-fcf8@secretlab.mine.nu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030422205721.GA1123@secretlab.mine.nu>
References: <20030422205721.GA1123@secretlab.mine.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051049388.15763.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Apr 2003 23:09:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-22 at 21:57, Walter Hofmann wrote:
> Using 2.4.20 I could enable DMA using "hdparm -d1 /dev/hda", but with 
> 2.4.21-rc1 I get "HDIO_SET_DMA failed: Operation not permitted".
> This is with a nForce2 chipset.

You dont appear to have the right drivers included in your kernel build.
At least the boot has no mentuon of the AMD/Nvidia driver

