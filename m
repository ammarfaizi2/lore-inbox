Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWJCLH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWJCLH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 07:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWJCLH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 07:07:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63955 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030305AbWJCLH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 07:07:29 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nicholas Miell <nmiell@comcast.net>, Adrian Bunk <bunk@stusta.de>,
       linuxppc-dev@ozlabs.org, Judith Lebzelter <judith@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1159850260.5482.34.camel@localhost.localdomain>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	 <20061002234428.GE3278@stusta.de>  <20061003012241.GF3278@stusta.de>
	 <1159840091.2349.0.camel@entropy>
	 <1159850260.5482.34.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2006 12:29:35 +0100
Message-Id: <1159874975.17553.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-03 am 14:37 +1000, ysgrifennodd Benjamin Herrenschmidt:
> > Won't this also cause warnings for valid arch-specific usage (i.e. in
> > linux/arch/{i386,x86_64})?
> 
> I wouldn't cause that usage valid :)

Actually a lot of the older legitimate users (DRM/AGP) have been cleaned
up so it might be worth doing now after all.

Ok I take back the NAK having looked deeper. We appear to have made
sufficient progress along the way.

Acked-by: Alan Cox <alan@redhat.com>


