Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753067AbWKFNXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbWKFNXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbWKFNXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:23:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54456 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1753062AbWKFNXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:23:31 -0500
Subject: Re: [PATCH] add pci revision id to struct pci_dev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Conke Hu <conke.hu@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
References: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Nov 2006 13:28:01 +0000
Message-Id: <1162819681.1566.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-11-06 am 20:40 +0800, ysgrifennodd Conke Hu:
> Hi all,
>     PCI revision id had better be added to struct pci_dev and
> initialized in pci_scan_device.

You can read the revision any time you like, we don't need to cache a
copy as we don't reference it very often

