Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263541AbRFAOkE>; Fri, 1 Jun 2001 10:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263546AbRFAOjy>; Fri, 1 Jun 2001 10:39:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8200 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263540AbRFAOje>; Fri, 1 Jun 2001 10:39:34 -0400
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
To: mark@somanetworks.com (Mark Frazer)
Date: Fri, 1 Jun 2001 15:37:19 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        zaitcev@redhat.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20010601103749.C5248@somanetworks.com> from "Mark Frazer" at Jun 01, 2001 10:37:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155q3E-0000bH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd argue for rate limiting as the application only gets back new data,
> never a cached value n times in a row.

Which is worse. I cat the proc file a few times and your HA app is unlucky. It
now gets *NO* data for five minutes. If we cache the values it gets approximate
data


