Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTFEKK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 06:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTFEKK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 06:10:26 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46726
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261968AbTFEKKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 06:10:25 -0400
Subject: Re: 2.4.21-rc7 AMD64 dpt_i2o fails compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Warren Togami <warren@togami.com>
Cc: amd64-list@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054799692.3699.77.camel@laptop>
References: <1054789161.3699.67.camel@laptop>
	 <20030605010841.A29837@devserv.devel.redhat.com>
	 <1054799692.3699.77.camel@laptop>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054808477.15276.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 11:21:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://www.togami.com/~warren/archive/2003/dpt_failure.txt
> 2.4.20-9.2 (GinGin64)
> Build failure when dpt is enabled as a module.  This is probably why
> this and many other kernel modules were not included in the GinGin64
> preview release.
> 
> Unfortunately it fails compilation in the same place for 2.4.21-rc7. 
> I'm testing 2.5.70-bk* next.
> 
> LKML, any existing patches for this dpt_i2o module AMD64 compilation
> issue?  Please CC me because not currently subscribed to lkml.

Fixing up dpt_i2o for the new DMA stuff is a major job. Fixing it for
64bit cleanness even more so.

