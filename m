Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbULGUPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbULGUPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbULGUNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:13:44 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:58060 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261919AbULGUNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:13:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=usiejVvEl5Sm+4yjd8tc21Y4GpsiPTubvY1NrS9PIqWZyX6PG7Sp1+Is0ZLwoMRXqJWlioUYx3XR1FiXH2muu/UAzjUBDwP0xGmj0bTJWzTS3SzrM40XCudzCRFca0rEMowqVdfz7nEhCghdzeJpcn4zYsOcRc4Mftl++TeyPqM=
Message-ID: <8e93903b04120712134a937f1b@mail.gmail.com>
Date: Tue, 7 Dec 2004 20:13:10 +0000
From: Alan Pope <alan.pope@gmail.com>
Reply-To: Alan Pope <alan.pope@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PDC202XX_OLD broken
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bugs@linux-ide.org, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <1102425655.17950.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8e93903b041206140529a8baa9@mail.gmail.com>
	 <1102425655.17950.21.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2004 13:21:02 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2004-12-06 at 22:05, Alan Pope wrote:
> > Added a "Seagate ST3200822A Barracuda 7200.7 Plus 200GB" disk to my
> > main PC which uses a with "Promise PDC20265 (FastTrak100
> > Lite/Ultra100) (rev 02)" controller.
> 
> Does it behave attached to a different disk controller ?
> 
> 

Thanks for the reply Alan, much appreciated.

No. I can confirm that when booted to Linux 2.6.7, plugged into a VIA
(onboard) VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev
06) it's does NOT exhibit the same problem. It's in DMA ATA33 mode on
that controller.

I have thrashed it with many dds of /dev/zero to the disk whilst
copying files around, and it's fine.

I've got some details at http://www.popey.com/promise if that helps.

Cheers,
Al.
