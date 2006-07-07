Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWGGRZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWGGRZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWGGRZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:25:59 -0400
Received: from outbound2.mail.tds.net ([216.170.230.92]:15328 "EHLO
	outbound2.mail.tds.net") by vger.kernel.org with ESMTP
	id S932209AbWGGRZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:25:58 -0400
Date: Fri, 7 Jul 2006 12:22:51 -0500 (CDT)
From: David Lloyd <dmlloyd@flurg.com>
To: Jeff Garzik <jeff@garzik.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       jamagallon@ono.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
In-Reply-To: <44AE966F.8090506@garzik.org>
Message-ID: <Pine.LNX.4.64.0607071222160.1933@ultros>
References: <20060703030355.420c7155.akpm@osdl.org>  <20060705234347.47ef2600@werewolf.auna.net>
  <20060705155602.6e0b4dce.akpm@osdl.org>  <20060706015706.37acb9af@werewolf.auna.net>
  <20060705170228.9e595851.akpm@osdl.org>  <20060706163646.735f419f@werewolf.auna.net>
  <20060706164802.6085d203@werewolf.auna.net>  <20060706234425.678cbc2f@werewolf.auna.net>
  <20060706145752.64ceddd0.akpm@osdl.org>  <1152288168.20883.8.camel@localhost.localdomain>
  <20060707175509.14ea9187@werewolf.auna.net>  <1152290643.20883.25.camel@localhost.localdomain>
  <20060707093432.571af16e.rdunlap@xenotime.net> <1152292196.20883.48.camel@localhost.localdomain>
 <44AE966F.8090506@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Jeff Garzik wrote:

> Alan Cox wrote:
>>  Also its dangerous to assume "pata_*" is a PATA driver, it may be SATA
>>  with a bridge chip, and in some cases like the ATI this is quite common.
>
> Incorrect; what you describe is the core assumption underlying the "ata_", 
> "pata_", and "sata_" prefixes.
>
> If the user can attached PATA and SATA devices to a controller, its prefix is 
> ata_

So sata_promise will change to ata_promise at some point?

- DML
