Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWDXUGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWDXUGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWDXUGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:06:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54196 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751216AbWDXUGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:06:53 -0400
Subject: Re: [kernel 2.6] Patch for mxser.c driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Bernard Pidoux <bpidoux@free.fr>, Bernard Pidoux <pidoux@ccr.jussieu.fr>,
       linux-kernel@vger.kernel.org
In-Reply-To: <444D1AD1.4000301@gmail.com>
References: <443C1DA0.1030004@ccr.jussieu.fr>  <443C2BF4.6070106@gmail.com>
	 <1144834562.1952.31.camel@localhost.localdomain> <444C913B.3020706@free.fr>
	 <444D1AD1.4000301@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 21:16:36 +0100
Message-Id: <1145909796.1635.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 20:36 +0159, Jiri Slaby wrote:
> Thanks for sources. The problem is, they still use deprecated api, they still
> pci_find_device, despite I applied them to correct it and they promise to at
> least try their best, unfortunately with no effect :(. I guess, if they don't
> convert it to pci probing, the driver won't be altered (delete 'if LINUXVERSION'
> and so on) to be re-merged as a new version.

Far better would be to diff their old driver and their new driver then
import the changes into the Linux driver proper. 

I've got their December 2004 driver (the one we originally worked from)
as an archive here if someone wants to do the work. Some of their later
changes did get imported but not all.

