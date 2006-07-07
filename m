Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWGGQ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWGGQ0t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWGGQ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:26:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52153 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932202AbWGGQ0r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:26:47 -0400
Subject: Re: 2.6.17-mm6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060707175509.14ea9187@werewolf.auna.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	 <20060705234347.47ef2600@werewolf.auna.net>
	 <20060705155602.6e0b4dce.akpm@osdl.org>
	 <20060706015706.37acb9af@werewolf.auna.net>
	 <20060705170228.9e595851.akpm@osdl.org>
	 <20060706163646.735f419f@werewolf.auna.net>
	 <20060706164802.6085d203@werewolf.auna.net>
	 <20060706234425.678cbc2f@werewolf.auna.net>
	 <20060706145752.64ceddd0.akpm@osdl.org>
	 <1152288168.20883.8.camel@localhost.localdomain>
	 <20060707175509.14ea9187@werewolf.auna.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Fri, 07 Jul 2006 17:44:03 +0100
Message-Id: <1152290643.20883.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-07 am 17:55 +0200, ysgrifennodd J.A. Magallón:
> I think it is enough to change the detection order, first real SATA and then
> PATA, so the only drives that change names are the PATA ones.
> (it that's easy enough...)

The order is determined by the PCI layer code, and of course by what
order you load the modules. Rigidly defined certainities about driver
ordering went out with hotplug. 

> Mmm, I have thought on another thing. RAID devices do not store the /dev
> node of pieces on the superblock, just drive IDs, isn't it ?

RAID just works and LVM. I flip Fedora boxes between drivers on a
regular basis without a glitch.


