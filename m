Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTIBTUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 15:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTIBTUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 15:20:53 -0400
Received: from palrel10.hp.com ([156.153.255.245]:7048 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263617AbTIBTUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 15:20:51 -0400
Date: Tue, 2 Sep 2003 12:20:43 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcel Holtmann <marcel@holtmann.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: request_firmware() backport to 2.4
Message-ID: <20030902192043.GD22376@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo wrote :
> On 1 Sep 2003, Marcel Holtmann wrote:
> 
> > no, the bfubase.frm is the original firmware file from AVM. This file
> > have to be placed somewhere on the filesystem. 
> 
> Right, and without placing the file somewhere on the filesystem bfusb
> 2.4.22 users wont have 2.4.23 working without "issues".

	But various high level kernel people, such as Jeff, have
decided that binary firmwares *must* be removed from the kernel
because of legal "issues" (GPL == source available). In 2.6.X, it
seems that the tolerance towards this "issue" will end, so all those
nasty details will have to work.
	Of course, 2.4.X is more "don't rock the boat".

	Have fun...

	Jean
