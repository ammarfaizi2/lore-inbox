Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbRAaXDc>; Wed, 31 Jan 2001 18:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129037AbRAaXDV>; Wed, 31 Jan 2001 18:03:21 -0500
Received: from quechua.inka.de ([212.227.14.2]:51565 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129049AbRAaXDR>;
	Wed, 31 Jan 2001 18:03:17 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <3A777E1A.8F124207@linux.com> <20010130220148.Y26953@ns> <3A77966E.444B1160@linux.com> <3A77C6E7.606DDA67@mountain.net> <20010131042616.A32636@cadcamlab.org> <3A77ED7F.466582F0@mountain.net> <14967.62112.447929.546585@wire.cadcamlab.org>
Organization: private Linux site, southern Germany
Date: Thu, 01 Feb 2001 00:01:56 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14O6GF-00062M-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, but if SMP for Athlons is not supported, what is the point in
> allowing CONFIG_SMP + CONFIG_MK7 (or CONFIG_SMP + CONFIG_MK6)?  Such a
> kernel will not run on *any* SMP system, since AMD kernels do not work
> on Intel.  If an AMD user really wants to carry around SMP baggage for
> no reason, let him use CONFIG_M586TSC.

Authors of drivers or other kernel add-on code often have to test
their stuff on a variety of configurations. _Especially_ on an SMP
kernel even if all they have is UP.

Olaf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
