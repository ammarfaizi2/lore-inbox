Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWKFO10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWKFO10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbWKFO10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:27:26 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7636 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751046AbWKFO1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:27:25 -0500
Subject: Re: [PATCH] add pci revision id to struct pci_dev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Conke Hu <conke.hu@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5767b9100611060610s6ac551cfwac97be19f075a0b6@mail.gmail.com>
References: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
	 <1162819681.1566.63.camel@localhost.localdomain>
	 <5767b9100611060610s6ac551cfwac97be19f075a0b6@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Nov 2006 14:31:52 +0000
Message-Id: <1162823512.1566.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-11-06 am 07:10 -0700, ysgrifennodd Conke Hu:
> > You can read the revision any time you like, we don't need to cache a
> > copy as we don't reference it very often
> I've searched the kernel soruce code and it seems that the revision id
> is widely used in pci drivers.

It is not however regularly and continually accessed - it doesn't need
caching.

Alan

