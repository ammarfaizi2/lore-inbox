Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTINPEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 11:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTINPEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 11:04:08 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:24479 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261178AbTINPEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 11:04:06 -0400
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Justin Cormack <justin@street-vision.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063538182.1510.78.camel@lotte.street-vision.com>
References: <1063484193.1781.48.camel@mulgrave>
	 <20030913212723.GA21426@gtf.org>
	 <1063538182.1510.78.camel@lotte.street-vision.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063551760.14837.10.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sun, 14 Sep 2003 16:02:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-14 at 12:15, Justin Cormack wrote:
> LABEL= is so broken that I immediately remove it from all my redhat
> systems. It is not unique at all. As soon as you plug another system
> disk into your system at boot time all hell breaks loose. At least it
> could have a random number in it or something.

You can use UUID's for labels too if you prefer. I normally write a 
host string into my labels. What I actually want is mount by label to
develop an rpc service so I can mount by label and if the disk is in
another box NFS it 8)

> If you need to know your bootdisk (why?) why not just get the bootloader
> to tell you?

The bootloader doesn't know. It has a bios concept of the boot device
which is really hard if at all possible to translate without things like
EDD.

