Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWGaPIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWGaPIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWGaPIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:08:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26312 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751153AbWGaPIk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:08:40 -0400
Subject: Re: [2.6.18-rc1-mm2] libata: DMA speed too slow for cdrecord
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20060731165122.08ac464e@werewolf.auna.net>
References: <20060729235431.322ea6d3@werewolf.auna.net>
	 <1154344141.7230.18.camel@localhost.localdomain>
	 <20060731165122.08ac464e@werewolf.auna.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 31 Jul 2006 16:27:46 +0100
Message-Id: <1154359666.7230.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-31 am 16:51 +0200, ysgrifennodd J.A. Magallón:
> What file is the new speed selection code in ? libata-core.c, ata-piix.c ?
> I can try to get the old kernel patched...

libata-core

> Or is there any patch available ?

Copy the working ata-piix.c from -mm1 into the -mm2 tree and try that,
it should do the trick for you.

