Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291533AbSBTBxs>; Tue, 19 Feb 2002 20:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291470AbSBTBxn>; Tue, 19 Feb 2002 20:53:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34053 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291592AbSBTBwl>; Tue, 19 Feb 2002 20:52:41 -0500
Subject: Re: compilation error: 2.4.18-rc2-ac1
To: alastair@altruxsolutions.co.uk
Date: Wed, 20 Feb 2002 02:06:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020219182354Z285720-889+3397@vger.kernel.org> from "Alastair Stevens" at Feb 19, 2002 06:23:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dM9O-0002EB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I received the following compilation error when building 2.4.18-rc2-ac1 under 
> Red Hat 7.2 on a dead ordinary i686 system (during "make modules") - hope 
> this is useful!

Strange.. it looks like something mangled your journal.ver file

cp .config ..
make distclean
cp ../.config .config
make oldconfig dep bzImage modules

and let me know what occured

Also before that take a look at journal.ver see what happened to it.
