Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265035AbTFLWtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbTFLWtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:49:14 -0400
Received: from vopmail.neto.com ([209.223.15.78]:13587 "EHLO vopmail.neto.com")
	by vger.kernel.org with ESMTP id S265043AbTFLWrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:47:20 -0400
Message-ID: <3EE9070A.4040403@neto.com>
Date: Thu, 12 Jun 2003 18:04:42 -0500
From: John T Copeland <johnc@neto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030315
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linuxkernel <linux-kernel@vger.kernel.org>
Subject: siimage driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
A couple of questions if you please.

1)  When I compile the siimage driver into the kernel, the ide buses are 
scanned in the following order:
  IDE0 - SATA primary - hda, hdb
  IDE1 - SATA secondary - hdc, hdd
  IDE2 - ATA tertiary - hde, hdf
  IDE3 - ATA quandrary hdg, hdh
I want the ATA to be IDE0/1  and SATA to be IDE2/3.  I have noticed from 
some of the posts about the siimage driver on the ASUS nforce2 mobo this 
is the apparent order scanned.  My mobo is an Abit NF7-S nforce2.  Is 
there someway of controlling the order of scannin the IDE buses?  I 
tried append="ide=reverse" to no avail.

2) To try and get the nforce2 IDE buses scanned first, I compiled 
siimage as a module, but when I did an "insmod siimage" I get an 
unresolved external, "noautodma", in siimage.

I'd appreciate any help you can offer.

Thanks,
John Copeland
 

