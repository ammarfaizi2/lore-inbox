Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTILKpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 06:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbTILKpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 06:45:53 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:52886 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261493AbTILKpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 06:45:52 -0400
Subject: Re: Problem: IDE data corruption with VIA chipsets
	on2.4.20-19.8+others
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Eric Bickle <ebickle@healthspace.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030912101454.A17364@bitwizard.nl>
References: <001601c37891$660cc5d0$5d74ad8e@hyperwolf>
	 <1063305812.3606.4.camel@dhcp23.swansea.linux.org.uk>
	 <20030912101454.A17364@bitwizard.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063363467.5330.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 11:44:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 09:14, Rogier Wolff wrote:
> Aug 10 06:54:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Aug 10 06:54:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }

Drive rejecting a command. Looks like smartd asked the drive to do
something it didnt support, which it really should not be doing.


