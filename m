Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWFTGiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWFTGiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWFTGiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:38:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12949 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964999AbWFTGiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:38:13 -0400
Subject: Re: PATA driver patch for 2.6.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b637ec0b0606192241w33eb7061kd32860b5b23db663@mail.gmail.com>
References: <1150740947.2871.42.camel@localhost.localdomain>
	 <e76uv1$g1s$1@sea.gmane.org>
	 <1150751279.2871.46.camel@localhost.localdomain>
	 <b637ec0b0606192241w33eb7061kd32860b5b23db663@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jun 2006 07:53:11 +0100
Message-Id: <1150786391.11062.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 07:41 +0200, ysgrifennodd Fabio Comolli:
> Is this patch supposed to be applied also on systems with only PATA
> drives? My laptop does not have SATA and does not show this bug.

The crash will only occur if you have SATA ports on a PIIX chip.
Applying it won't do any harm.

I'll put up a -ide2 today with it folded in

