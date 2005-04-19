Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVDSTpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVDSTpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVDSTpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:45:09 -0400
Received: from v6.netlin.pl ([62.121.136.6]:31239 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261639AbVDSTpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:45:00 -0400
Message-ID: <42655FA4.3030304@pointblue.com.pl>
Date: Tue, 19 Apr 2005 21:44:36 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hama card reader 19in1 question on USB (not workie)
References: <4264F3DD.7090204@pointblue.com.pl> <20050419133659.GA401@DervishD>
In-Reply-To: <20050419133659.GA401@DervishD>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks dude, it worked !


DervishD wrote:
>     Hi Grzegorz :)
> 
>  * Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl> dixit:
> 
>>Apr 19 14:03:49 thinkpaddie kernel:   Vendor: USB Read  Model: CF Card
>>     CF  Rev: 1.8D
>>Apr 19 14:03:49 thinkpaddie kernel:   Type:   Direct-Access
>>         ANSI SCSI revision: 00
> 
> [...]
> 
>>But no SD card is detected, and I can't mount the card.
> 
> 
>     Only the first LUN is being detected. You need a kernel with
> CONFIG_SCSI_MULTI_LUN in order to have all slots detected in the card
> reader. I have a 8-in-1 card reader with 4 slots and I need multiple
> LUN support.
> 
>     Try that ;)
> 
>     Raúl Núñez de Arenas Coronado
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCZV+ki0HtPCVkDAURAl+SAJ9EtCRBO1al5Q/jkYXAgMEpMdpmuACdE9ix
0g6SWend2Gta9G7mJuHR26o=
=0c55
-----END PGP SIGNATURE-----
