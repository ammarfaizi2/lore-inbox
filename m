Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291713AbSBHScE>; Fri, 8 Feb 2002 13:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291712AbSBHSbr>; Fri, 8 Feb 2002 13:31:47 -0500
Received: from pop.gmx.net ([213.165.64.20]:16163 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291707AbSBHSbd>;
	Fri, 8 Feb 2002 13:31:33 -0500
Message-ID: <3C64196F.CBA321AE@gmx.net>
Date: Fri, 08 Feb 2002 19:31:11 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Guest section DW: "Re: [PATCH] Fix floppy io portsreservation
In-Reply-To: <5.1.0.14.2.20020208160020.027998a0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

> Even if yours are affected you are unlikely to be wanting to enable PNPBIOS
> support in the kernel for them. And as long as you don't do that everything
> will continue to work as before my patch. The work around for this would be
> for the PNPBIOS driver in the kernel not to reserve ports 0x3f0 and 0x3f1
> on systems without a PNPBIOS. Thus on all recent systems PNPBIOS would take
> over 0x3f0 and 0x3f1

This is a misunderstanding.

Compiling PNPBIOS into the kernel does _not_ mean 0x3f0 will be reserved.

So the legacy floppy ports are not a PNPBIOS issue on any machine.

-
Gunther

