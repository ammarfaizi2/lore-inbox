Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTKFTrK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTKFTrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:47:10 -0500
Received: from gaia.cela.pl ([213.134.162.11]:15370 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263807AbTKFTrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:47:08 -0500
Date: Thu, 6 Nov 2003 20:45:41 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Matthew Reppert <repp0017@tc.umn.edu>
cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <1068140559.359.5.camel@minerva>
Message-ID: <Pine.LNX.4.44.0311062044390.21501-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You have CONFIG_USB_STORAGE=y in your config; USB storage does a
> "select SCSI", which means that if USB storage is active, it forces
> CONFIG_SCSI=y. So, if you turn off USB storage, you can turn off SCSI.

> Making USB storage a module won't help; select seems to always select Y.

Now that I would say is a bug, it should either default to the item 
which selected it or somehow ask during configuration...

Cheers,
MaZe.


