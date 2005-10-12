Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVJLRYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVJLRYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVJLRYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:24:15 -0400
Received: from [81.2.110.250] ([81.2.110.250]:6555 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932440AbVJLRYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:24:13 -0400
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
In-Reply-To: <434D3266.9000203@gentoo.org>
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>
	 <434D3266.9000203@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Oct 2005 18:52:43 +0100
Message-Id: <1129139563.7966.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-10-12 at 16:57 +0100, Daniel Drake wrote:
> Uh, looks like the kernel just assumes 33mhz unless overriden by the user. Is 
> this assumption generally accurate?
> If it is not, then there's probably no point displaying timing info...

A small number of 486 systems use 25Mhz, some boards allow overclock at
37.5Mhz on the PCI. I've been looking at this the past couple of days
for the libata via driver which I've been porting over and unfortunately
having been through the Northbridge manuals I can find no way to ask the
chipset what the PCI clock is set too.

Alan

