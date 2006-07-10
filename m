Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWGJJoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWGJJoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWGJJoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:44:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55237 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751381AbWGJJoh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:44:37 -0400
Subject: Re: 2.6.18-rc1-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060710023311.169251c4@werewolf.auna.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <20060710023311.169251c4@werewolf.auna.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 10 Jul 2006 11:02:22 +0100
Message-Id: <1152525742.27368.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 02:33 +0200, ysgrifennodd J.A. Magallón:
> builtin, host detenction seems to go in PCI order but... promise detects
> first the SATA drives. I'm trying to get a way to predict what switchng
> from IDE to libata will do on my boxes, but...

PCI order. Some controllers put the PATA ports before the SATA ones,
some controllers the reverse, some even mix them up according to BIOS
setup. Generally they are doing this so the user can land their
preferred disk type as BIOS disk 0x80 (C:) for booting.

Alan
