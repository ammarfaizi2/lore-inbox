Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284704AbRLEVB1>; Wed, 5 Dec 2001 16:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284710AbRLEVBU>; Wed, 5 Dec 2001 16:01:20 -0500
Received: from t2.redhat.com ([199.183.24.243]:43772 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284704AbRLEVBJ>; Wed, 5 Dec 2001 16:01:09 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0112051532140.20543-100000@freak.distro.conectiva> 
In-Reply-To: <Pine.LNX.4.21.0112051532140.20543-100000@freak.distro.conectiva> 
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, dhinds@sonic.net
Subject: Re: Linux 2.4.17-pre3 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Dec 2001 21:01:04 +0000
Message-ID: <10031.1007586064@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.4.16/drivers/pcmcia/rsrc_mgr.c      Mon Nov 26 08:35:03 2001
+++ linux/drivers/pcmcia/rsrc_mgr.c     Tue Dec  4 17:25:30 2001

+       return pci_find_parent_resource(dev, &res);

This change breaks all CONFIG_PCMCIA, !CONFIG_PCI builds.

--
dwmw2


