Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSA1WJr>; Mon, 28 Jan 2002 17:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSA1WJd>; Mon, 28 Jan 2002 17:09:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50443 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286934AbSA1WIX>; Mon, 28 Jan 2002 17:08:23 -0500
Subject: Re: 2.4.18-pre7 slow ... apm problem
To: jdthood@mail.com (Thomas Hood)
Date: Mon, 28 Jan 2002 22:20:51 +0000 (GMT)
Cc: jchua@fedex.com (Jeff Chua), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel),
        sfr@canb.auug.org.au (Stephen Rothwell),
        skraw@ithnet.com (Stephan von Krawczynski)
In-Reply-To: <1012249707.4807.123.camel@thanatos> from "Thomas Hood" at Jan 28, 2002 03:28:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VK8x-0001zG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Question to all: Would it be a good idea to de-idle the CPU
> inside interrupt handlers?

If you call APM routines from inside APM routines weirdness occurs - so
the answer is no. I'd say that unless this is shown to be occuring in
non vmware stuff its up to vmware to handle the apm situation right

