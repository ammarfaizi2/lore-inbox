Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTEFK1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbTEFK1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:27:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45734
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262499AbTEFK1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:27:03 -0400
Subject: Re: [IDE] trying to make MO drive work with ide-floppy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305052154200.1105-100000@neptune.local>
References: <Pine.LNX.4.44.0305052154200.1105-100000@neptune.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052214062.28792.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 10:41:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-05 at 21:04, Pascal Schmidt wrote:
> Are there any plans to support drives with blocksizes != 512 bytes? What 
> changes would be needed to make it work? Or do I simply have to live with 
> ide-scsi (still broken on 2.5, I assume...)?

I'm not aware of any plans to make ide-floppy handle that disk, or reasons
you would want to use ide floppy in 2.5 not the ide-cd layer (which does now
handle writable devices I believe).



