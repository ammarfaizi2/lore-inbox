Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283266AbRK2PZP>; Thu, 29 Nov 2001 10:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283274AbRK2PYz>; Thu, 29 Nov 2001 10:24:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10248 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283270AbRK2PYr>; Thu, 29 Nov 2001 10:24:47 -0500
Subject: Re: rpm builder of kernel image
To: hch@caldera.de (Christoph Hellwig)
Date: Thu, 29 Nov 2001 15:33:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), maftoul@esrf.fr (Samuel Maftoul),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011129161519.A9688@caldera.de> from "Christoph Hellwig" at Nov 29, 2001 04:15:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169TBi-0000LZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, that's even older than my tool.  But I don't think we want that
> infrastructure inside the kernel.

Oh I think you do.

>  - there are lots of packaging systems

two in mainstream use. Debian dpkg and RPM. 

>  - there even are lots of incompatible rpm versions

There are some features in the newer RPM. The make rpm target avoids them
and sticks to directives present in the LSB specified RPM version.

>  - you really want to plug into some vendor-infrastructure, e.g.
>    boot loader configuration

That I do want to improve on. I have some ideas.

>  - sooner or later I want to add some system to auto-apply patches
>    (similar to what debian does)

	patch < blah
	make config
	make rpm

Alan

